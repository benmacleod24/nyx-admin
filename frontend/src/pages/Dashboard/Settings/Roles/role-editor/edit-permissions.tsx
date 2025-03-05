import { useFormContext } from "react-hook-form";
import { UpdateRoleFormSchema } from ".";
import { useState } from "react";
import { TPermission } from "@/types/api/permissions";
import { Search } from "lucide-react";
import { FormControl, FormField, FormItem } from "@/components/ui/form";
import { Switch } from "@/components/ui/switch";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";

export default function EditRolePermissions(props: { permissions: TPermission[] }) {
	const [filter, setFilter] = useState<string>("");
	const form = useFormContext<UpdateRoleFormSchema>();
	const { permissions, hasPermission } = useAuth();

	return (
		<div>
			<div className="flex items-center justify-between">
				<h2 className="text-lg font-semibold">Role Permissions</h2>
				<div className="flex items-center w-full border rounded-lg min-h-10 px-2 max-w-xs">
					<Search className="mr-2 text-muted-foreground" />
					<input
						value={filter}
						onChange={(e) => setFilter(e.target.value)}
						className="w-full h-10 bg-transparent border-none outline-none"
						placeholder="Search Permissions"
					/>
				</div>
			</div>

			<div className="grid grid-cols-1 gap-4 mt-5">
				{props.permissions
					.filter(
						(p) =>
							p.description?.toLowerCase().includes(filter.toLowerCase()) ||
							p.friendlyName.toLowerCase().includes(filter.toLowerCase())
					)
					.map((permission) => (
						<FormField
							key={permission.key}
							control={form.control}
							name={permission.key}
							render={({ field }) => (
								<FormItem className="border rounded-lg p-4">
									<div className="flex items-center justify-between">
										<h4 className="truncate font-medium">
											{permission.friendlyName}
										</h4>
										<FormControl>
											<Switch
												checked={Boolean(field.value)}
												onCheckedChange={field.onChange}
												disabled={
													!permissions?.includes(permission.key) ||
													!hasPermission(Permissions.ModifyRoles)
												}
												aria-readonly
												className="data-[state=checked]:bg-brand"
												thumbClassName="data-[state=checked]:bg-white"
											/>
										</FormControl>
									</div>
									<p className="text-sm text-muted-foreground max-w-2xl">
										{permission.description}
									</p>
								</FormItem>
							)}
						/>
					))}
			</div>
		</div>
	);
}
