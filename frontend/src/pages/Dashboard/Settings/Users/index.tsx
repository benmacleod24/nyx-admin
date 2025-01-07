import DashboardLayout from "@/components/layouts/Dashboard";
import ContentLoader from "@/components/ui/content-loader";
import { useAuth } from "@/hooks";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TUser } from "@/types";
import useSWR from "swr";
import { useLocation } from "wouter";
import UserSelector from "./user-selector";

export default function UsersSettingsPage() {
	const [_, setLocation] = useLocation();
	const { hasPermission, isPermissionsReady } = useAuth();

	// The user has access to this page.
	const hasAccessPermission = isPermissionsReady && hasPermission(Permissions.ViewRoles);

	// Get all the users.
	const {
		data: users,
		isLoading: isUsersLoading,
		error: usersError,
	} = useSWR<TUser[]>(ApiEndponts.User.GetAllUsers);

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
						<div className="w-full h-full grid grid-cols-4">
							<UserSelector users={users} />
						</div>
					);
				}}
			</ContentLoader>
		</DashboardLayout>
	);
}
