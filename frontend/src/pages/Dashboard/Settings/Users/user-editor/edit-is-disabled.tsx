import { useFormContext } from "react-hook-form";
import { TEditUserFormSchema } from ".";
import { FormControl, FormDescription, FormField, FormItem, FormLabel } from "@/components/ui/form";
import { Switch } from "@/components/ui/switch";
import { Label } from "@/components/ui/label";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";

export default function EditIsDisabled() {
	const { hasPermission } = useAuth();
	const form = useFormContext<TEditUserFormSchema>();

	return (
		<FormField
			control={form.control}
			name="isDisabled"
			render={({ field }) => (
				<FormItem>
					<div className="mb-2">
						<FormLabel>Enabled/Disable User Account</FormLabel>
						<FormDescription>
							Determine weather this user is allowed to log in or not.
						</FormDescription>
					</div>
					<div className="w-full flex items-center gap-2">
						<FormControl>
							<Switch
								disabled={!hasPermission(Permissions.ModifyUsers)}
								checked={field.value}
								onCheckedChange={field.onChange}
							/>
						</FormControl>
						<Label>Disabled</Label>
					</div>
				</FormItem>
			)}
		/>
	);
}
