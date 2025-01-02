import DashboardLayout from "@/components/layouts/Dashboard";
import { useAuth } from "@/hooks";

export default function DashboardHome() {
	const { roleKey } = useAuth();
	return <DashboardLayout>{roleKey}</DashboardLayout>;
}
