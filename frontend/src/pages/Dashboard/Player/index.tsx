import DashboardLayout from "@/components/layouts/Dashboard";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Separator } from "@/components/ui/separator";
import { ApiEndponts } from "@/lib/config";
import { formatDate, formatPhoneNumber } from "@/lib/utils";
import { TPlayer } from "@/types";
import { ArrowLeft, BadgeCheck, Briefcase, CreditCard, MoveLeft, Users } from "lucide-react";
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
		<DashboardLayout className="p-5">
			<div className="mb-5 flex items-center justify-between">
				<Button variant={"outline"} onClick={() => history.back()}>
					<ArrowLeft /> Back to Players
				</Button>
			</div>
			<div className="grid grid-cols-4 gap-5">
				<Card>
					<CardHeader>
						<CardTitle className="flex items-center">
							<BadgeCheck className="mr-2 h-5 w-5 mt-1 text-brand" />
							Personal Information
						</CardTitle>
						<CardDescription>Citizen identity and personal details.</CardDescription>
					</CardHeader>
					<CardContent className="space-y-4">
						<div className="grid grid-cols-2 gap-4">
							<div>
								<p className="text-sm text-muted-foreground">Full Name</p>
								<p className="font-medium capitalize">
									{playerData.charInfo.firstname} {playerData.charInfo.lastname}
								</p>
							</div>
							<div>
								<p className="text-sm text-muted-foreground">Played By</p>
								<p className="font-medium">{playerData.name}</p>
							</div>
							<div>
								<p className="text-sm text-muted-foreground">Phone</p>
								<p className="font-medium">
									{formatPhoneNumber(playerData.phoneNumber)}
								</p>
							</div>
							<div>
								<p className="text-sm text-muted-foreground">Gender</p>
								<p className="font-medium">
									{playerData.charInfo.gender === 0 ? "Male" : "Female"}
								</p>
							</div>
							<div>
								<p className="text-sm text-muted-foreground uppercase">
									Nationality
								</p>
								<p className="font-medium">{playerData.charInfo.nationality}</p>
							</div>
							<div>
								<p className="text-sm text-muted-foreground">Date of Birth</p>
								<p className="font-medium">
									{formatDate(playerData.charInfo.birthdate)}
								</p>
							</div>
						</div>
						<Separator />
						<div>
							<p className="text-sm text-muted-foreground">Citizen ID</p>
							<p className="font-mono truncate">{playerData.citizenId}</p>
						</div>
						<div>
							<p className="text-sm text-muted-foreground">License</p>
							<p className="font-mono truncate text-sm">
								{playerData.license.split(":")[1]}
							</p>
						</div>
					</CardContent>
				</Card>

				{/* Financial Information */}
				<Card>
					<CardHeader>
						<CardTitle className="flex items-center">
							<CreditCard className="mr-2 h-6 w-6 mt-0.5 text-brand" />
							Financial Information
						</CardTitle>
						<CardDescription>Citizen's financial assets</CardDescription>
					</CardHeader>
					<CardContent>
						<div className="space-y-4">
							<div>
								<p className="text-sm text-muted-foreground">Bank Balance</p>
								<p className="text-2xl font-bold">
									${playerData.money.bank.toLocaleString()}
								</p>
							</div>
							<div className="mt-1">
								<p className="text-sm text-muted-foreground">Account Number</p>
								<p className="font-mono text-xs">{playerData.charInfo.account}</p>
							</div>
							<Separator />
							<div className="grid grid-cols-2 gap-4">
								<div>
									<p className="text-sm text-muted-foreground">Cash</p>
									<p className="font-medium">
										${playerData.money.cash.toLocaleString()}
									</p>
								</div>
								<div>
									<p className="text-sm text-muted-foreground">Crypto</p>
									<p className="font-medium">
										${playerData.money.crypto.toLocaleString()}
									</p>
								</div>
							</div>
						</div>
					</CardContent>
				</Card>

				{/* Job Information */}
				<Card>
					<CardHeader>
						<CardTitle className="flex items-center">
							<Briefcase className="mr-2 h-5 w-5 mt-1 text-brand" />
							Employment
						</CardTitle>
						<CardDescription>Job details and status</CardDescription>
					</CardHeader>
					<CardContent>
						<div className="space-y-4">
							<div>
								<p className="text-sm text-muted-foreground">Job</p>
								<div className="flex items-center gap-2">
									<p className="font-medium">{playerData.job.label}</p>
									{playerData.job.onDuty && (
										<Badge
											variant="default"
											className="bg-green-600 text-white"
										>
											On Duty
										</Badge>
									)}
								</div>
							</div>
							<div className="grid grid-cols-2 gap-4">
								<div>
									<p className="text-sm text-muted-foreground">Position</p>
									<p className="font-medium">{playerData.job.grade.name}</p>
								</div>
								<div>
									<p className="text-sm text-muted-foreground">Rank</p>
									<p className="font-medium">
										Level {playerData.job.grade.level}
									</p>
								</div>
								<div>
									<p className="text-sm text-muted-foreground">Payment</p>
									<p className="font-medium">${playerData.job.payment}/hr</p>
								</div>
								<div>
									<p className="text-sm text-muted-foreground">Type</p>
									<p className="font-medium uppercase">{playerData.job.type}</p>
								</div>
							</div>
							{playerData.job.isBoss && (
								<div className="mt-2">
									<Badge
										variant="outline"
										className="border-yellow-500 text-yellow-500"
									>
										Management Position
									</Badge>
								</div>
							)}
						</div>
					</CardContent>
				</Card>

				{/* Gang Information */}
				<Card>
					<CardHeader>
						<CardTitle className="flex items-center">
							<Users className="mr-2 h-5 w-5 text-brand mt-1" />
							Gang Affiliation
						</CardTitle>
						<CardDescription>Gang membership details</CardDescription>
					</CardHeader>
					<CardContent>
						{playerData.gang.name === "none" ? (
							<div className="flex h-24 items-center justify-center">
								<p className="text-muted-foreground">No gang affiliation</p>
							</div>
						) : (
							<div className="space-y-4">
								<div>
									<p className="text-sm text-muted-foreground">Gang</p>
									<p className="font-medium">{playerData.gang.label}</p>
								</div>
								<div className="grid grid-cols-2 gap-4">
									<div>
										<p className="text-sm text-muted-foreground">Rank</p>
										<p className="font-medium">{playerData.gang.grade.name}</p>
									</div>
									<div>
										<p className="text-sm text-muted-foreground">Level</p>
										<p className="font-medium">{playerData.gang.grade.level}</p>
									</div>
								</div>
								{playerData.gang.isBoss && (
									<div className="mt-2">
										<Badge
											variant="outline"
											className="border-red-500 text-red-500"
										>
											Gang Leader
										</Badge>
									</div>
								)}
							</div>
						)}
					</CardContent>
				</Card>
			</div>
		</DashboardLayout>
	);
}
