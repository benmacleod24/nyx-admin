import DashboardLayout from "@/components/layouts/Dashboard";
import { Button } from "@/components/ui/button";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";
import { GripVertical, Plus } from "lucide-react";
import useSWR from "swr";
import { useLocation } from "wouter";
import CreateRole from "./create-role";
import ContentLoader from "@/components/ui/content-loader";
import { TRole } from "@/types";
import RoleEditor from "./role-editor";
import { useEffect, useState } from "react";
import { cn } from "@/lib/utils";
import RoleSelector from "./role-selector";

export default function RoleSettingsPage() {
	const [editingRoleKey, setEditingRoleKey] = useState<string>("");
	const { hasPermission, isPermissionsReady } = useAuth();
	const [_, navigate] = useLocation();

	const { data, isLoading, error } = useSWR<TRole[]>("/api/roles");

	// Handle settings the default editing role.
	useEffect(() => {
		if (data && data.length >= 1) {
			// TODO: Set to the highest level the user can edit.
			setEditingRoleKey(data[0].key);
		}
	}, [data]);

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

			<div className="mt-5 flex items-start">
				<div className="w-1/5">
					<ContentLoader data={{ roles: data }} isLoading={[isLoading]} errors={[error]}>
						{({ roles }) => {
							return (
								<RoleSelector
									editingRoleKey={editingRoleKey}
									roles={roles}
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
