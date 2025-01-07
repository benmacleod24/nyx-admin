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

export default function EditUserPassword() {
	const form = useFormContext<TEditUserFormSchema>();

	return (
		<FormField
			control={form.control}
			name="password"
			render={({ field }) => (
				<FormItem className="flex flex-col justify-between">
					<div>
						<FormLabel>User Password</FormLabel>
						<FormDescription>
							Modify the users password incase they forget it.
						</FormDescription>
					</div>
					<div className="max-w-md w-full min-w-[20rem] mt-1">
						<FormControl>
							<Input type="password" placeholder="••••••••••" {...field} />
						</FormControl>
						<FormMessage />
					</div>
				</FormItem>
			)}
		/>
	);
}
