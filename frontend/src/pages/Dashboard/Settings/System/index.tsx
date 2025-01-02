import DashboardLayout from "@/components/layouts/Dashboard";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";
import { useLocation } from "wouter";

export default function SystemSettings() {
	const { hasPermission, isPermissionsReady } = useAuth();
	const [_, navigate] = useLocation();

	if (!isPermissionsReady) return;

	if (isPermissionsReady && !hasPermission(Permissions.ViewSystemSettings)) {
		navigate("/");
		return;
	}

	return <DashboardLayout>System Settings</DashboardLayout>;
}
