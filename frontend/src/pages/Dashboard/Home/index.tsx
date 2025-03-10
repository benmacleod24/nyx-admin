import DashboardLayout from "@/components/layouts/Dashboard";
import EconomyOverview from "./economy-overview";

export default function DashboardHome() {
	return (
		<DashboardLayout className="p-5">
			<div className="grid grid-cols-2 gap-5">
				<EconomyOverview />
			</div>
		</DashboardLayout>
	);
}
