import { Avatar, AvatarImage } from "@/components/ui/avatar";
import { useAuth } from "@/hooks";
import { cn } from "@/lib/utils";
import { TRole } from "@/types";
import { GripVertical, Lock, User } from "lucide-react";
import React, { useCallback, useMemo, useState } from "react";
import { useAutoAnimate } from "@formkit/auto-animate/react";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { mutate } from "swr";
import { useAtom, useSetAtom } from "jotai";
import {
	editingRoleAtom,
	shouldAniamteUnsaveChangesAtom,
	unsavedRoleChangesAtom,
} from "@/lib/state/pages/manage-roles";

// Function to reorder the role array.
function reorder<T>(list: T[], startIndex: number, endIndex: number) {
	const result = Array.from(list);
	const [removed] = result.splice(startIndex, 1);
	result.splice(endIndex, 0, removed);

	return result;
}

export default function RoleSelector(props: { roles: TRole[] }) {
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

	if (!props.roles) return;

	return (
		<div className="grid gap-2" ref={animateRef}>
			{props.roles.map((r, idx) => (
				<RoleOption
					role={r}
					roles={props.roles}
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
	index: number;
	roles: TRole[];
	draggedIndex: number | null;
	setDraggedIndex: (v: number | null) => void;
	onDrop: (s: number, e: number) => void;
}) {
	const [hovered, setHovered] = useState(false);
	const { role: userRole, hasPermission } = useAuth();

	const setAnimateUnsavedChanges = useSetAtom(shouldAniamteUnsaveChangesAtom);
	const [activeEditingRole, setActiveEditingRole] = useAtom(editingRoleAtom);
	const [unsavedRoleChanges] = useAtom(unsavedRoleChangesAtom);

	// Handle setting a role for active.
	function handleRoleClick() {
		if (!isDroppable) return;

		// Notify user unsaved changes.
		if (unsavedRoleChanges) {
			setAnimateUnsavedChanges(true);
			setTimeout(() => {
				setAnimateUnsavedChanges(false);
			}, 1500);
			return;
		}

		setActiveEditingRole(props.role);
	}

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
			if (props.draggedIndex === null) return;

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
			{hovered &&
				isDroppable &&
				props.draggedIndex !== null &&
				props.index < props.draggedIndex && (
					<div className="w-full h-0.5 bg-brand mb-1 rounded-full" />
				)}

			{/* <pre>
				{JSON.stringify(
					{ hovered, isDroppable, draggedIndex: props.draggedIndex },
					null,
					2
				)}
			</pre> */}
			<div
				draggable={isDroppable && hasPermission(Permissions.ModifyRoles)}
				onDrag={handleDragStart}
				onDragOver={handleDragOver}
				onDragLeave={() => setHovered(false)}
				onDragEnd={() => setHovered(false)}
				onDrop={handleDrop}
				onClick={handleRoleClick}
				className={cn(
					"flex items-center border rounded-lg p-2 gap-2 select-none cursor-pointer",
					isDroppable && "hover:bg-muted transition-all",
					!isDroppable && "cursor-not-allowed text-muted-foreground",
					activeEditingRole && activeEditingRole.id === props.role.id && "bg-muted",
					hasPermission(Permissions.ModifyRoles) && "cursor-move"
				)}
			>
				{!isDroppable ? (
					<Lock size={15} />
				) : hasPermission(Permissions.ModifyRoles) ? (
					<GripVertical size={18} />
				) : (
					<User size={18} />
				)}
				<Avatar className="w-3.5 h-3.5">
					<AvatarImage
						src={`https://avatar.vercel.sh/${props.role.friendlyName}.svg`}
						className={cn(!isDroppable && "grayscale")}
					/>
				</Avatar>
				<p>{props.role.friendlyName}</p>
			</div>
			{hovered &&
				isDroppable &&
				props.draggedIndex !== null &&
				props.index > props.draggedIndex && (
					<div className="w-full h-0.5 bg-brand mt-1 rounded-full" />
				)}
		</div>
	);
}
