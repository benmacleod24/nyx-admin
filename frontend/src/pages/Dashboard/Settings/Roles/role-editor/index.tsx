import { Button } from "@/components/ui/button";
import { Form } from "@/components/ui/form";
import { ApiEndponts } from "@/lib/config";
import {
	editingRoleAtom,
	shouldAniamteUnsaveChangesAtom,
	unsavedRoleChangesAtom,
} from "@/lib/state/pages/manage-roles";
import { cn } from "@/lib/utils";
import { TPermission } from "@/types/api/permissions";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAtom } from "jotai";
import { Loader, Save } from "lucide-react";
import { useCallback, useEffect, useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import EditRoleName from "./edit-name";
import { Separator } from "@/components/ui/separator";
import EditRolePermissions from "./edit-permissions";
import DeleteRole from "./delete-role";
import Fade from "@/components/ui/fade";
import { Fetch } from "@/lib";

export type UpdateRoleFormSchema = z.infer<typeof formSchema>;
const formSchema = z
	.object({
		name: z.string(),
		roleKey: z.ostring(),
	})
	.passthrough();

export default function RoleEditor(props: {}) {
	const [permissions, setPermissions] = useState<TPermission[]>([]);

	const [role] = useAtom(editingRoleAtom);
	const [shouldAniamteUnsaveChanges] = useAtom(shouldAniamteUnsaveChangesAtom);
	const [unsavedChanges, setUnsavedChanges] = useAtom(unsavedRoleChangesAtom);

	const getDefaultFormData = useCallback(async () => {
		// Get the permissions the role already has.
		const activePermissions = await Fetch.Get<string[]>(
			ApiEndponts.Roles.GetPermissions(role!.key),
			{ includeCredentials: true }
		);

		const permissions = await Fetch.Get<TPermission[]>(ApiEndponts.Permissions.Get, {
			includeCredentials: true,
		});

		if (!permissions.ok || !permissions.data || !activePermissions.data)
			return formSchema.parse({});

		let formData: UpdateRoleFormSchema = {
			roleKey: role!.key || "",
			name: role!.friendlyName || "",
		};

		for (const permission of permissions.data) {
			formData[permission.key] = activePermissions.data.includes(permission.key);
		}

		setPermissions(permissions.data);

		return formSchema.parse(formData);
	}, [role]);

	const form = useForm<UpdateRoleFormSchema>({
		resolver: zodResolver(formSchema),
		defaultValues: getDefaultFormData,
	});

	const { isDirty } = form.formState;
	useEffect(() => {
		setUnsavedChanges(isDirty);
	}, [isDirty]);

	useEffect(() => {
		getDefaultFormData().then((r) => form.reset(r));
	}, [role]);

	async function onSubmit(values: UpdateRoleFormSchema) {
		const permissionKeys = permissions.map((p) => p.key);

		let newRoleData: Record<string, any> = {};
		let newRolePermissions: string[] = [];

		for (const key in values) {
			if (permissionKeys.includes(key) && typeof values[key] === "boolean" && values[key]) {
				newRolePermissions.push(key);
			} else {
				newRoleData[key] = values[key];
			}
		}

		const resp = await Fetch.Put(`/api/roles/${role?.key}`, {
			includeCredentials: true,
			body: {
				permissions: newRolePermissions,
			},
		});

		console.log(resp);

		if (resp.ok) {
			form.reset(await getDefaultFormData());
		}
	}

	async function resetForm() {
		form.reset(await getDefaultFormData(), { keepValues: false, keepDefaultValues: false });
	}

	if (!role) return;

	return (
		<Form {...form}>
			<form onSubmit={form.handleSubmit(onSubmit)} className="pb-10">
				<EditRoleName />
				<Separator className="my-7" />
				<EditRolePermissions permissions={permissions} />
				<DeleteRole />
				<Fade open={unsavedChanges} className="max-w-2xl w-full absolute bottom-5">
					<div className="max-w-2xl w-full flex items-center justify-center">
						<div
							className={cn(
								"flex items-center justify-between w-full z-[100] transition-all bg-zinc-900 p-2 pl-3 border rounded-lg",
								shouldAniamteUnsaveChanges && "animate-shake border-red-500"
							)}
						>
							<p className="">Careful — you have unsaved changes!</p>
							<div className="flex items-center gap-2">
								<Button
									variant={"link"}
									size={"sm"}
									onClick={(e) => {
										e.preventDefault();
										resetForm();
									}}
								>
									Reset
								</Button>
								<Button
									size={"sm"}
									type="submit"
									className="bg-green-500 text-white hover:bg-green-600"
								>
									{form.formState.isSubmitting ? (
										<Loader className="animate-spin" />
									) : (
										<Save />
									)}{" "}
									Save Changes
								</Button>
							</div>
						</div>
					</div>
				</Fade>
			</form>
		</Form>
	);
}
