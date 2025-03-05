import DashboardLayout from "@/components/layouts/Dashboard";
import { ApiEndponts } from "@/lib/config";
import { TPlayer } from "@/types";
import useSWR from "swr";
import { useParams } from "wouter";

export default function PlayerPage() {
	const params = useParams<{ id: string }>();

	const { data: playerData } = useSWR<TPlayer>(params.id && ApiEndponts.Players.Get(params.id));

	if (!params.id)
		return (
			<DashboardLayout>
				<p>Citzen ID not found.</p>
			</DashboardLayout>
		);

	if (!playerData)
		return (
			<DashboardLayout>
				<p>Player Not Found</p>
			</DashboardLayout>
		);

	return (
		<DashboardLayout>
			<pre>{JSON.stringify(playerData.charInfo, null, 2)}</pre>
		</DashboardLayout>
	);
}
