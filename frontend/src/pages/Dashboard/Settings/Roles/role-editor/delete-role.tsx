import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import {
	ResponsiveModal,
	ResponsiveModalClose,
	ResponsiveModalContent,
	ResponsiveModalDescription,
	ResponsiveModalFooter,
	ResponsiveModalHeader,
	ResponsiveModalTitle,
	ResponsiveModalTrigger,
} from "@/components/ui/responsive-modal";
import { Separator } from "@/components/ui/separator";
import { useAuth } from "@/hooks";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { editingRoleAtom } from "@/lib/state/pages/manage-roles";
import { useAtomValue } from "jotai";
import React, { useState } from "react";
import { mutate } from "swr";

export default function DeleteRole() {
	const { hasPermission } = useAuth();
	const editingRole = useAtomValue(editingRoleAtom);

	if (!hasPermission(Permissions.DeleteRoles)) return;
	if (editingRole && !editingRole.canBeDeleted) return;

	return (
		<React.Fragment>
			<Separator className="my-7" />
			<div>
				<div>
					<h1 className="font-semibold text-red-400 text-lg">Danger Zone</h1>
					<p className="text-sm text-red-200 max-w-2xl mt-1">
						You are about to delete this role. If you delete this role it can not be
						recovered and all users with this role with default to the basic user role.
					</p>
				</div>
				<div className="mt-5">
					<DeleteRoleModal />
				</div>
			</div>
		</React.Fragment>
	);
}

function DeleteRoleModal() {
	const [open, setOpen] = useState<boolean>(false);
	const [confirmText, setConfirmText] = useState<string>("");
	const editingRole = useAtomValue(editingRoleAtom);

	async function handleDelete() {
		if (!editingRole) return;
		const resp = await Fetch.Delete(ApiEndponts.Roles.DeleteRole(editingRole.key), {
			includeCredentials: true,
		});

		if (resp.ok) {
			await mutate(ApiEndponts.Roles.GetRoles);
			setOpen(false);
		}
	}

	return (
		<ResponsiveModal open={open} onOpenChange={setOpen}>
			<ResponsiveModalTrigger asChild>
				<Button
					variant={"outline"}
					className="border-red-500 text-red-500 hover:bg-red-300/20 hover:text-red-500"
				>
					Yes, Delete {editingRole?.friendlyName}
				</Button>
			</ResponsiveModalTrigger>
			<ResponsiveModalContent>
				<ResponsiveModalHeader>
					<ResponsiveModalTitle>Delete Role</ResponsiveModalTitle>
					<ResponsiveModalDescription>
						Please confirm you want to delete the {editingRole?.friendlyName} by typing
						the name in the text input below.
					</ResponsiveModalDescription>
				</ResponsiveModalHeader>
				<div>
					<p className="text-sm text-muted-foreground mb-1">
						Please Enter,{" "}
						<span className="font-semibold">{editingRole?.friendlyName}</span> to
						confirm.
					</p>
					<Input
						value={confirmText}
						onChange={(e) => setConfirmText(e.target.value)}
						placeholder={`${editingRole?.friendlyName}`}
					/>
				</div>
				<ResponsiveModalFooter>
					<ResponsiveModalClose asChild>
						<Button variant={"link"}>Cancel</Button>
					</ResponsiveModalClose>
					<Button
						variant={"outline"}
						className="border-red-500 text-red-500 hover:bg-red-300/20 hover:text-red-500 disabled:grayscale disabled:cursor-not-allowed"
						onClick={handleDelete}
						disabled={
							confirmText.toLowerCase() !== editingRole?.friendlyName.toLowerCase()
						}
					>
						Confirm
					</Button>
				</ResponsiveModalFooter>
			</ResponsiveModalContent>
		</ResponsiveModal>
	);
}
