import { Form } from "@/components/ui/form";
import { editingUserAtom, unsavedUserChangesAtom } from "@/lib/state/pages/manage-users";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAtom, useSetAtom } from "jotai";
import { useCallback, useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import EditUserPassword from "./edit-password";
import { Separator } from "@/components/ui/separator";
import EditUserRole from "./edit-role";
import SaveBar from "./save-bar";
import EditIsDisabled from "./edit-is-disabled";
import EditUsername from "./edit-username";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TUser } from "@/types";
import { mutate } from "swr";
import { useToast } from "@/hooks/use-toast";
import { useAuth } from "@/hooks";

export type TEditUserFormSchema = z.infer<typeof editUserFormSchema>;
const editUserFormSchema = z.object({
	username: z.string(),
	roleKey: z.ostring(),
	password: z.ostring(),
	isDisabled: z.boolean(),
});

export default function UserEditor() {
	const { toast } = useToast();
	const { hasPermission } = useAuth();
	const [editingUser, setEditingUser] = useAtom(editingUserAtom);
	const setUnsavedUserChanges = useSetAtom(unsavedUserChangesAtom);

	const getDefaultValues = useCallback(async () => {
		return editUserFormSchema.parse({
			username: editingUser?.userName || "",
			roleKey: editingUser?.role!.key || "",
			isDisabled: editingUser?.isDisabled || false,
			password: "",
		});
	}, [editingUser]);

	const form = useForm<TEditUserFormSchema>({
		resolver: zodResolver(editUserFormSchema),
		defaultValues: getDefaultValues,
	});

	useEffect(() => {
		getDefaultValues().then((r) => form.reset(r));
	}, [editingUser]);

	const { isDirty } = form.formState;
	useEffect(() => {
		setUnsavedUserChanges(isDirty);
	}, [isDirty]);

	async function onSubmit(values: TEditUserFormSchema) {
		if (!editingUser) return;
		if (!hasPermission(Permissions.ModifyUsers)) return;

		const resp = await Fetch.Put<TUser>(
			ApiEndponts.Users.UpdateUser(editingUser.id.toString()),
			{
				includeCredentials: true,
				body: {
					userId: editingUser.id,
					userName: values.username,
					password: values.password,
					roleKey: values.roleKey,
					isDisabled: values.isDisabled,
				},
			}
		);

		if (resp.ok && resp.data) {
			await mutate(ApiEndponts.User.GetAllUsers);
			setEditingUser(resp.data);
			await resetForm();
			return;
		}

		if (!resp.ok) {
			toast({
				title: "Error Occured",
				description: resp.message || "Internal Service Error",
				variant: "destructive",
			});
		}
	}

	async function resetForm() {
		form.reset(await getDefaultValues(), {
			keepValues: false,
			keepDefaultValues: false,
			keepDirty: false,
		});
	}

	if (!editingUser) return;

	return (
		<div className="col-span-3 w-full h-full overflow-auto">
			<div className="w-full h-20 flex flex-col justify-center border-b px-5">
				<h1 className="text-lg font-medium">Editing User — {editingUser?.userName}</h1>
				<p className="text-sm text-muted-foreground">
					Modify role, password, username, and more.
				</p>
			</div>

			{/* Content */}
			<div className="p-5 px-10">
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)}>
						<EditUsername />
						<Separator className="my-7" />
						<EditUserRole />
						<Separator className="my-7" />
						<EditUserPassword />
						<Separator className="my-7" />
						<EditIsDisabled />
						<SaveBar resetForm={resetForm} />
					</form>
				</Form>
			</div>
		</div>
	);
}
