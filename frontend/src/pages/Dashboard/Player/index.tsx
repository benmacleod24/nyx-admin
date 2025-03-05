import DashboardLayout from "@/components/layouts/Dashboard";
import { useParams } from "wouter";

export default function PlayerPage() {
	const params = useParams();

	return (
		<DashboardLayout>
			<pre>{JSON.stringify(params, null, 2)}</pre>
		</DashboardLayout>
	);
}
