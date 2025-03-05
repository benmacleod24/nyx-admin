import DashboardLayout from "@/components/layouts/Dashboard";
import { useAuth } from "@/hooks";
import { ApiEndponts, Permissions } from "@/lib/config";
import useSWR from "swr";
import { useLocation } from "wouter";
import CreateRole from "./create-role";
import ContentLoader from "@/components/ui/content-loader";
import { TRole } from "@/types";
import RoleEditor from "./role-editor";
import { useEffect, useState } from "react";
import RoleSelector from "./role-selector";
import { Search } from "lucide-react";
import { useAtom } from "jotai";
import { editingRoleAtom } from "@/lib/state/pages/manage-roles";

export default function RoleSettingsPage() {
	const { hasPermission, isPermissionsReady, role: userRole, isLoggedIn } = useAuth();
	const [_, navigate] = useLocation();
	const [filter, setFilter] = useState("");

	const [editingRole, setEditingRole] = useAtom(editingRoleAtom);

	const { data, isLoading, error } = useSWR<TRole[]>(isLoggedIn && ApiEndponts.Roles.GetRoles);

	// Handle settings the default editing role.
	useEffect(() => {
		if (data && data.length >= 1 && userRole) {
			// Remove roles user doesn't have access to.
			const roles = data
				.filter((r) => r.orderLevel < userRole.orderLevel)
				.sort((a, b) => b.orderLevel - a.orderLevel);

			// Set default viewed role to highest access role.
			if (roles[0]) {
				setEditingRole(roles[0]);
			}
		}
	}, [data, userRole]);

	if (!isPermissionsReady) return "permissions not ready";
	if (isPermissionsReady && !hasPermission([Permissions.ViewRoles])) {
		navigate("/");
		return;
	}

	return (
		<DashboardLayout className="px-0 pt-0 flex flex-col relative overflow-hidden">
			<div className="w-full h-full grid grid-cols-4">
				<div className="w-full col-span-1 border-r h-full">
					<div className="w-full h-20 mb-5 flex flex-col justify-center border-b px-5">
						<h1 className="text-lg font-semibold">Manage Roles</h1>
						<p className="text-sm text-muted-foreground">Modify & Create user roles.</p>
					</div>
					<div className="px-5">
						<div className="flex items-center gap-2 mb-2">
							<div className="flex items-center w-full border rounded-lg min-h-10 px-2">
								<Search className="mr-2 text-muted-foreground" />
								<input
									value={filter}
									onChange={(e) => setFilter(e.target.value)}
									className="w-full h-10 bg-transparent border-none outline-none"
									placeholder="Search Roles"
								/>
							</div>
							<CreateRole />
						</div>
						<ContentLoader
							data={{ roles: data }}
							isLoading={[isLoading]}
							errors={[error]}
						>
							{({ roles }) => {
								if (!Array.isArray(roles)) return <></>;

								return (
									<RoleSelector
										roles={roles.filter((r) =>
											r.friendlyName
												.toLowerCase()
												.includes(filter.toLowerCase())
										)}
									/>
								);
							}}
						</ContentLoader>
					</div>
				</div>
				<div className="w-full h-full col-span-3 overflow-auto">
					<div className="w-full h-20 flex flex-col justify-center mb-5 border-b px-10">
						<h1 className="text-lg font-medium">
							Edit Role — {editingRole?.friendlyName}
						</h1>
						<p className="text-sm text-muted-foreground">
							Modifying permissions and information about {editingRole?.friendlyName}
						</p>
					</div>
					<div className="px-10">
						<RoleEditor />
					</div>
				</div>
			</div>
		</DashboardLayout>
	);
}
