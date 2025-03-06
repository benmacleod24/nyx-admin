import DashboardLayout from "@/components/layouts/Dashboard";
import { Button } from "@/components/ui/button";
import { ApiEndponts } from "@/lib/config";
import { TPlayer } from "@/types";
import { MoveLeft } from "lucide-react";
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
			<div className="w-full h-full p-5 grid grid-cols-4">
				<div className="w-full h-fit p-3 border rounded-xl">
					<h1 className="text-xl font-bold capitalize">
						{playerData.charInfo.firstname} {playerData.charInfo.lastname}
					</h1>
					<div className="mt-2">
						<div className="text-sm flex items-center gap-2">
							<p className="font-medium text-muted-foreground">Citizen ID:</p>
							<span className="font-mono">{playerData.citizenId}</span>
						</div>
					</div>
				</div>
			</div>
		</DashboardLayout>
	);
}
