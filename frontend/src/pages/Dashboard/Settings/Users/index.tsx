import DashboardLayout from "@/components/layouts/Dashboard";
import ContentLoader from "@/components/ui/content-loader";
import { useAuth } from "@/hooks";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TUser } from "@/types";
import useSWR from "swr";
import { useLocation } from "wouter";
import UserSelector from "./user-selector";
import { useEffect } from "react";
import { useSetAtom } from "jotai";
import { editingUserAtom } from "@/lib/state/pages/manage-users";
import UserEditor from "./user-editor";

export default function UsersSettingsPage() {
	const [_, setLocation] = useLocation();
	const { hasPermission, isPermissionsReady, role, user } = useAuth();
	const setEditingUser = useSetAtom(editingUserAtom);

	// The user has access to this page.
	const hasAccessPermission = isPermissionsReady && hasPermission(Permissions.ViewRoles);

	// Get all the users.
	const {
		data: users,
		isLoading: isUsersLoading,
		error: usersError,
	} = useSWR<TUser[]>(ApiEndponts.User.GetAllUsers);

	useEffect(() => {
		if (users) {
			// All the users the current user has access to.
			const _users = users
				.filter((u) => u.id !== user.id)
				.filter((u) => u.role?.orderLevel! < role?.orderLevel!)
				.sort((a, b) => b.role?.orderLevel! - a.role?.orderLevel!);

			if (_users[0]) {
				setEditingUser(_users[0]);
				return;
			}
		}
	}, [users]);

	// Verify user has permissions to access this page.
	if (!isPermissionsReady) return;
	if (!hasAccessPermission) {
		setLocation("/");
		return;
	}

	return (
		<DashboardLayout>
			<ContentLoader data={{ users }} errors={[usersError]} isLoading={[isUsersLoading]}>
				{({ users }) => {
					return (
						<div className="w-full h-full grid grid-cols-4 relative">
							<UserSelector users={users} />
							<UserEditor />
						</div>
					);
				}}
			</ContentLoader>
		</DashboardLayout>
	);
}
