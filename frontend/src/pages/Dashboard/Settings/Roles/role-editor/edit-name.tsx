import { useFormContext } from "react-hook-form";
import { UpdateRoleFormSchema } from ".";
import {
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";

export default function EditRoleName() {
	const form = useFormContext<UpdateRoleFormSchema>();

	return (
		<FormField
			control={form.control}
			name="name"
			render={({ field }) => (
				<FormItem className="flex flex-col justify-between">
					<div>
						<FormLabel>Role Name</FormLabel>
						<FormDescription>
							Give the role a simple name people will understand. Something basic like
							Support Tier 2.
						</FormDescription>
					</div>
					<div className="max-w-md w-full min-w-[20rem] mt-1">
						<FormControl>
							<Input placeholder="shadcn" {...field} />
						</FormControl>
						<FormMessage />
					</div>
				</FormItem>
			)}
		/>
	);
}
