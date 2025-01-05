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

export default function RoleSettingsPage() {
	const [editingRoleKey, setEditingRoleKey] = useState<string>("");
	const { hasPermission, isPermissionsReady, role: userRole } = useAuth();
	const [_, navigate] = useLocation();
	const [filter, setFilter] = useState("");

	const { data, isLoading, error } = useSWR<TRole[]>(ApiEndponts.Roles.GetRoles);

	// Handle settings the default editing role.
	useEffect(() => {
		if (data && data.length >= 1 && userRole) {
			// Remove roles user doesn't have access to.
			const roles = data
				.filter((r) => r.orderLevel < userRole.orderLevel)
				.sort((a, b) => b.orderLevel - a.orderLevel);

			// Set default viewed role to highest access role.
			if (roles[0]) {
				setEditingRoleKey(roles[0].key);
			}
		}
	}, [data, userRole]);

	if (!isPermissionsReady) return;
	if (isPermissionsReady && !hasPermission([Permissions.ViewRoles])) {
		navigate("/");
		return;
	}

	return (
		<DashboardLayout className="px-8 pt-5">
			<div className="flex items-center gap-10">
				<div>
					<h1 className="text-xl font-semibold">Manage User Roles</h1>
					<p className="text-sm text-muted-foreground">Modify and create user roles</p>
				</div>
			</div>

			<div className="mt-5 flex items-start gap-10">
				<div className="w-1/5">
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
					<ContentLoader data={{ roles: data }} isLoading={[isLoading]} errors={[error]}>
						{({ roles }) => {
							return (
								<RoleSelector
									editingRoleKey={editingRoleKey}
									roles={roles.filter((r) =>
										r.friendlyName.toLowerCase().includes(filter.toLowerCase())
									)}
									setEditingRole={setEditingRoleKey}
								/>
							);
						}}
					</ContentLoader>
				</div>
				<div className="w-4/5 h-10">
					<RoleEditor roleKey={editingRoleKey} />
				</div>
			</div>
		</DashboardLayout>
	);
}
