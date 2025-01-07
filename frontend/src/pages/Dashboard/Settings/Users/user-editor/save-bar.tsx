import { useFormContext } from "react-hook-form";
import { TEditUserFormSchema } from ".";
import { useAtom, useAtomValue } from "jotai";
import {
	editingUserAtom,
	shouldAniamteUnsavedUserChangesAtom,
	unsavedUserChangesAtom,
} from "@/lib/state/pages/manage-users";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Loader, Save } from "lucide-react";
import { useEffect } from "react";

export default function SaveBar(props: { resetForm: () => void }) {
	const form = useFormContext<TEditUserFormSchema>();

	const editingUser = useAtomValue(editingUserAtom);
	const unsavedChanges = useAtomValue(unsavedUserChangesAtom);
	const shouldAnimateUnsavedChanges = useAtomValue(shouldAniamteUnsavedUserChangesAtom);

	return (
		<div className="absolute bottom-5 max-w-2xl left-1/2 w-full -translate-x-1/2 flex items-center justify-center">
			<div
				className={cn(
					"flex items-center justify-between w-full z-[100] transition-all bg-zinc-900 p-2 pl-3 border rounded-lg",
					shouldAnimateUnsavedChanges && "animate-shake border-red-500",
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
							props.resetForm();
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
	);
}
