import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { useAuth } from "@/hooks";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TPlayer } from "@/types";
import { LinkIcon, Loader } from "lucide-react";
import useSWR from "swr";
import { Link } from "wouter";

export default function RelatedCitizens({ citizenId }: { citizenId: string }) {
	const { hasPermission, isPermissionsReady } = useAuth();

	const hasRelatedCitizensPermission =
		isPermissionsReady && hasPermission(Permissions.ViewRelatedCitizens);

	const { data: relatedCitizens, isLoading } = useSWR<TPlayer[]>(
		hasRelatedCitizensPermission && ApiEndponts.Citizens.GetRelatedCitizens(citizenId)
	);

	if (!hasRelatedCitizensPermission) return;

	return (
		<Card className="col-span-2 mt-2">
			<CardHeader>
				<CardTitle className="flex items-center">
					<LinkIcon className="mr-2 h-5 w-5 text-brand mt-1" />
					Related Citizens
				</CardTitle>
				<CardDescription>Citizens sharing the same license</CardDescription>
			</CardHeader>
			<CardContent>
				{isLoading && (
					<div className="flex justify-center">
						<Loader className="text-brand animate-spin" />
					</div>
				)}

				{!isLoading && relatedCitizens && relatedCitizens.length >= 1 ? (
					<Table>
						<TableHeader>
							<TableRow>
								<TableHead className="w-[100px]">ID</TableHead>
								<TableHead>Name</TableHead>
								<TableHead className="w-[100px] text-right">Actions</TableHead>
							</TableRow>
						</TableHeader>
						<TableBody>
							{relatedCitizens &&
								Array.isArray(relatedCitizens) &&
								relatedCitizens.map((citizen) => (
									<TableRow key={citizen.citizenId}>
										<TableCell className="font-mono text-xs">
											{citizen.citizenId}
										</TableCell>
										<TableCell className="font-medium capitalize">
											{citizen.charInfo.firstname} {citizen.charInfo.lastname}
										</TableCell>
										<TableCell className="text-right">
											<Button variant="ghost" size="sm" asChild>
												<Link href={`/citizens/${citizen.citizenId}`}>
													View
												</Link>
											</Button>
										</TableCell>
									</TableRow>
								))}
						</TableBody>
					</Table>
				) : (
					<div className="flex h-24 items-center justify-center">
						<p className="text-muted-foreground">No Related Citizens</p>
					</div>
				)}
			</CardContent>
		</Card>
	);
}
