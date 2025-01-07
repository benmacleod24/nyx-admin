import { useFormContext } from "react-hook-form";
import { TEditUserFormSchema } from ".";
import {
	Form,
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import useSWR from "swr";
import { ApiEndponts } from "@/lib/config";
import { TRole } from "@/types";
import ContentLoader from "@/components/ui/content-loader";
import React from "react";
import { useAuth } from "@/hooks";

export default function EditUserRole() {
	const form = useFormContext<TEditUserFormSchema>();
	const { role } = useAuth();

	const { data, error, isLoading } = useSWR<TRole[]>(ApiEndponts.Roles.GetRoles);

	return (
		<FormField
			control={form.control}
			name="roleId"
			render={({ field }) => (
				<FormItem className="flex flex-col justify-between">
					<div>
						<FormLabel>User Role</FormLabel>
						<FormDescription>
							User role to assign various permissions to the user.
						</FormDescription>
					</div>
					<div className="max-w-md w-full min-w-[20rem] mt-1">
						<Select
							onValueChange={(v) => {
								if (!v) return;
								field.onChange(v);
							}}
							value={field.value}
						>
							<FormControl>
								<SelectTrigger>
									<SelectValue placeholder="Select a Role" />
								</SelectTrigger>
							</FormControl>
							<SelectContent>
								<ContentLoader
									data={{ roles: data }}
									isLoading={[isLoading]}
									errors={[error]}
								>
									{({ roles }) => (
										<React.Fragment>
											{roles.map((_role) => (
												<SelectItem
													disabled={role!.orderLevel <= _role.orderLevel}
													key={_role.id}
													value={_role.key}
												>
													{_role.friendlyName}
												</SelectItem>
											))}
										</React.Fragment>
									)}
								</ContentLoader>
							</SelectContent>
						</Select>
						<FormMessage />
					</div>
				</FormItem>
			)}
		/>
	);
}
