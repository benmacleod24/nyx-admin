import { Avatar, AvatarImage } from "@/components/ui/avatar";
import { useAuth } from "@/hooks";
import { cn } from "@/lib/utils";
import { TRole } from "@/types";
import { GripVertical, Lock } from "lucide-react";
import React, { useCallback, useMemo, useState } from "react";
import { useAutoAnimate } from "@formkit/auto-animate/react";
import { Fetch } from "@/lib";
import { ApiEndponts } from "@/lib/config";
import { mutate } from "swr";

// Function to reorder the role array.
function reorder<T>(list: T[], startIndex: number, endIndex: number) {
	const result = Array.from(list);
	const [removed] = result.splice(startIndex, 1);
	result.splice(endIndex, 0, removed);

	return result;
}

export default function RoleSelector(props: {
	roles: TRole[];
	editingRoleKey: string;
	setEditingRole: (v: string) => void;
}) {
	// Used to track which element is being dragged.
	const [draggedIndex, setDraggedIndex] = useState<number | null>(null);
	// Auto animate ref for smooth arranging of the list.
	const [animateRef] = useAutoAnimate();

	// Handle the dropping of elements.
	async function handleDrop(sourceIndex: number, endIndex: number) {
		// Reorder the role list
		const newRoleOrder = reorder(props.roles, sourceIndex, endIndex);

		// Map each roleId to the new order level from the sort.
		const roleIdWithIndexList = newRoleOrder.reverse().map((role, index) => ({
			roleId: role.id,
			orderLevel: index,
		}));

		// Update the role order with the server.
		const resp = await Fetch.Post(ApiEndponts.Roles.UpdateOrder, {
			includeCredentials: true,
			body: roleIdWithIndexList,
		});

		// Server verified all data and response with new data.
		if (resp.ok && resp.data && Array.isArray(resp.data)) {
			await mutate(ApiEndponts.Roles.GetRoles, resp.data);
		}
	}

	return (
		<div className="grid gap-2" ref={animateRef}>
			{props.roles.map((r, idx) => (
				<RoleOption
					role={r}
					roles={props.roles}
					setRoleActive={() => props.setEditingRole(r.key)}
					isActiveRole={props.editingRoleKey === r.key}
					key={r.id}
					index={idx}
					onDrop={handleDrop}
					setDraggedIndex={setDraggedIndex}
					draggedIndex={draggedIndex}
				/>
			))}
		</div>
	);
}

function RoleOption(props: {
	role: TRole;
	setRoleActive: () => void;
	isActiveRole: boolean;
	index: number;
	roles: TRole[];
	draggedIndex: number | null;
	setDraggedIndex: (v: number | null) => void;
	onDrop: (s: number, e: number) => void;
}) {
	const [hovered, setHovered] = useState(false);
	const { role: userRole } = useAuth();

	// Determine if the option is droppable.
	const isDroppable = useMemo(() => {
		const userRoleIndex = props.roles.findIndex((r) => r.id === userRole?.id);
		return props.index > userRoleIndex;
	}, [props.index, userRole, props.role]);

	// Handle the starting of a drag
	function handleDragStart(e: React.DragEvent<HTMLDivElement>) {
		if (!isDroppable) {
			e.preventDefault();
			return;
		}

		props.setDraggedIndex(props.index);
	}

	// Handle the dragging over an element.
	function handleDragOver(e: React.DragEvent<HTMLDivElement>) {
		e.preventDefault();
		setHovered(true);
	}

	// Handle the dropping of this event.
	const handleDrop = useCallback(
		(e: React.DragEvent<HTMLDivElement>) => {
			e.preventDefault();
			if (!props.draggedIndex) return;

			// Get the index of role the user has.
			const indexOfUserRole = props.roles.findIndex((r) => r.id === userRole?.id);

			// Check that the user can drop at that given index.
			if (props.index <= indexOfUserRole) {
				setHovered(false);
				return;
			}

			// Process drop event.
			props.onDrop(props.draggedIndex, props.index);
			setHovered(false);
		},
		[props.draggedIndex, props.index, userRole]
	);

	return (
		<div>
			{hovered && isDroppable && props.draggedIndex && props.index < props.draggedIndex && (
				<div className="w-full h-0.5 bg-brand mb-1 rounded-full" />
			)}
			<div
				draggable={isDroppable}
				onDrag={handleDragStart}
				onDragOver={handleDragOver}
				onDragLeave={() => setHovered(false)}
				onDragEnd={() => setHovered(false)}
				onDrop={handleDrop}
				onClick={isDroppable ? props.setRoleActive : () => {}}
				className={cn(
					"flex items-center border rounded-lg p-2 gap-2 select-none",
					isDroppable && "cursor-move hover:bg-muted transition-all",
					!isDroppable && "cursor-not-allowed text-muted-foreground",
					props.isActiveRole && "bg-muted"
				)}
			>
				{!isDroppable ? <Lock size={15} /> : <GripVertical size={18} />}
				<Avatar className="w-3.5 h-3.5">
					<AvatarImage
						src={`https://avatar.vercel.sh/${props.role.friendlyName}.svg`}
						className={cn(!isDroppable && "grayscale")}
					/>
				</Avatar>
				<p>{props.role.friendlyName}</p>
			</div>
			{hovered && isDroppable && props.draggedIndex && props.index > props.draggedIndex && (
				<div className="w-full h-0.5 bg-brand mt-1 rounded-full" />
			)}
		</div>
	);
}
