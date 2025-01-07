import { Button } from "@/components/ui/button";
import ContentLoader from "@/components/ui/content-loader";
import { Form, FormControl, FormField, FormItem } from "@/components/ui/form";
import { Switch } from "@/components/ui/switch";
import { useAuth } from "@/hooks";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import {
	editingRoleAtom,
	shouldAniamteUnsaveChangesAtom,
	unsavedRoleChangesAtom,
} from "@/lib/state/pages/manage-roles";
import { cn } from "@/lib/utils";
import { TRole } from "@/types";
import { TPermission } from "@/types/api/permissions";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAtom, useAtomValue } from "jotai";
import { Loader, Save, Search } from "lucide-react";
import { useCallback, useEffect, useMemo, useState } from "react";
import { useForm, useFormContext } from "react-hook-form";
import useSWR from "swr";
import { boolean, z, ZodBoolean } from "zod";
import EditRoleName from "./edit-name";
import { Separator } from "@/components/ui/separator";
import EditRolePermissions from "./edit-permissions";
import DeleteRole from "./delete-role";
import { useLocation, useRouter } from "wouter";

export type UpdateRoleFormSchema = z.infer<typeof formSchema>;
const formSchema = z
	.object({
		name: z.string(),
		roleKey: z.ostring(),
	})
	.passthrough();

function permissionKeysToZodEntry() {
	let permissionEntries: Record<string, ZodBoolean> = {};

	for (const key of Object.values(Permissions)) {
		permissionEntries[key] = z.boolean();
	}

	return permissionEntries;
}

export default function RoleEditor(props: {}) {
	const [filter, setFilter] = useState<string>("");
	const [permissions, setPermissions] = useState<TPermission[]>([]);

	const [role, setRole] = useAtom(editingRoleAtom);
	const [shouldAniamteUnsaveChanges, setShouldAnimateUnsaveChanges] = useAtom(
		shouldAniamteUnsaveChangesAtom
	);
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

				{form.formState.isDirty && (
					<div className="absolute bottom-5 max-w-2xl left-1/2 w-full -translate-x-1/2 flex items-center justify-center">
						<div
							className={cn(
								"flex items-center justify-between w-full z-[100] transition-all bg-zinc-900 p-2 pl-3 border rounded-lg",
								shouldAniamteUnsaveChanges && "animate-shake border-red-500",
								unsavedChanges && "opacity-100 pointer-events-auto",
								!unsavedChanges && "opacity-0 pointer-events-none"
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
				)}
			</form>
		</Form>
	);
}
