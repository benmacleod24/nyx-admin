import { useFormContext } from "react-hook-form";
import { TEditUserFormSchema } from ".";
import {
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";

export default function EditUsername() {
	const { hasPermission } = useAuth();
	const form = useFormContext<TEditUserFormSchema>();

	return (
		<FormField
			control={form.control}
			name="username"
			render={({ field }) => (
				<FormItem>
					<div className="flex flex-col justify-between">
						<FormLabel>Username</FormLabel>
						<FormDescription>
							We DISCOURAGE changing peoples usernames however we give you the option
							to do it here.
						</FormDescription>
					</div>
					<div className="max-w-md w-full min-w-[20rem] mt-1">
						<FormControl>
							<Input
								disabled={!hasPermission(Permissions.ModifyUsers)}
								placeholder="jscott"
								{...field}
							/>
						</FormControl>
						<FormMessage />
					</div>
				</FormItem>
			)}
		/>
	);
}
