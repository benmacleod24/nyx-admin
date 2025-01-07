import { Form } from "@/components/ui/form";
import { useAuth } from "@/hooks";
import {
	editingUserAtom,
	shouldAniamteUnsavedUserChangesAtom,
	unsavedUserChangesAtom,
} from "@/lib/state/pages/manage-users";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAtom, useAtomValue, useSetAtom } from "jotai";
import { useCallback, useEffect } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import EditUserPassword from "./edit-password";
import { Separator } from "@/components/ui/separator";
import EditUserRole from "./edit-role";
import SaveBar from "./save-bar";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Loader, Save } from "lucide-react";

export type TEditUserFormSchema = z.infer<typeof editUserFormSchema>;
const editUserFormSchema = z.object({
	username: z.string(),
	roleId: z.ostring(),
	password: z.ostring(),
});

export default function UserEditor() {
	const [editingUser, setEditingUser] = useAtom(editingUserAtom);
	const [unsavedChanges, setUnsavedUserChanges] = useAtom(unsavedUserChangesAtom);
	const shouldAniamteUnsaveChanges = useAtomValue(shouldAniamteUnsavedUserChangesAtom);

	const getDefaultValues = useCallback(async () => {
		return editUserFormSchema.parse({
			username: editingUser?.userName || "",
			roleId: editingUser?.role!.key || "",
		});
	}, [editingUser]);

	useEffect(() => {
		console.log(editingUser);
	}, [editingUser]);

	const form = useForm<TEditUserFormSchema>({
		resolver: zodResolver(editUserFormSchema),
		// defaultValues: getDefaultValues,
	});

	useEffect(() => {
		getDefaultValues().then((r) => form.reset(r));
	}, [editingUser]);

	const { isDirty } = form.formState;
	useEffect(() => {
		setUnsavedUserChanges(isDirty);
	}, [isDirty]);

	async function onSubmit(values: TEditUserFormSchema) {
		// Submit form.
	}

	async function resetForm() {
		form.reset(await getDefaultValues());
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
						{/* <EditUserRole /> */}
						<Separator className="my-7" />
						<EditUserPassword />
						<Separator className="my-7" />

						{form.formState.isDirty && (
							<div className="absolute bottom-5 max-w-2xl left-1/2 w-full -translate-x-1/2 flex items-center justify-center">
								<div
									className={cn(
										"flex items-center justify-between w-full z-[100] transition-all bg-zinc-900 p-2 pl-3 border rounded-lg",
										shouldAniamteUnsaveChanges &&
											"animate-shake border-red-500",
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
												// e.preventDefault();
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
			</div>
		</div>
	);
}
