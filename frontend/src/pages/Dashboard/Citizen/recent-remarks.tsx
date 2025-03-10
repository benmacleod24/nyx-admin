import { Button } from "@/components/ui/button";
import {
	Card,
	CardContent,
	CardDescription,
	CardFooter,
	CardHeader,
	CardTitle,
} from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Separator } from "@/components/ui/separator";
import { Textarea } from "@/components/ui/textarea";
import { useAuth } from "@/hooks";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { formatDateTime, toQuery } from "@/lib/utils";
import { TRemark } from "@/types/api/remarks";
import { ArrowRight, MessageSquare, Search } from "lucide-react";
import React from "react";
import { useState } from "react";
import useSWR from "swr";
import { Link } from "wouter";

export default function CitizenRemarks({
	license,
	citizenId,
}: {
	license: string;
	citizenId: string;
}) {
	const [newRemark, setNewRemark] = useState("");
	const [isAddingRemark, setIsAddingRemark] = useState(false);

	const { hasPermission } = useAuth();

	const { data: latestRemarks, mutate } = useSWR<TRemark[]>(
		hasPermission(Permissions.ViewPlayerRemarks) &&
			ApiEndponts.Remarks.Get(license) + `?${toQuery({ limit: "3" })}`
	);

	// Update the handleAddRemark function
	const handleAddRemark = async (e: React.FormEvent) => {
		e.preventDefault();
		e.stopPropagation();
		if (!newRemark.trim()) return;

		const res = await Fetch.Post<TRemark>(ApiEndponts.Remarks.Create, {
			includeCredentials: true,
			body: {
				content: newRemark,
				license: license,
			},
		});

		if (res.ok && res.data) {
			setNewRemark("");
			setIsAddingRemark(false);

			if (latestRemarks) {
				mutate([res.data, ...latestRemarks.slice(0, 2)]);
			} else {
				mutate([res.data]);
			}
		}
	};

	// Scan through the remark text and look for citizen ids and replace with link.
	const formattedText = (text: string) =>
		text.split(/\bUPV\d{5}\b/g).map((part, index, array) => {
			if (index < array.length - 1) {
				const match = text.match(/\bUPV\d{5}\b/g)?.[index];
				return (
					<React.Fragment key={index}>
						{part}
						{match && (
							<Link
								href={`/citizens/${match}`}
								className={"text-brand hover:underline"}
							>
								{match}
							</Link>
						)}
					</React.Fragment>
				);
			}
			return part;
		});

	return (
		<Card className="col-span-2 mt-2">
			<CardHeader>
				<div className="flex items-center justify-between">
					<CardTitle className="flex items-center">
						<MessageSquare className="mr-2 h-5 w-5 text-brand mt-1" />
						Recent Remarks
					</CardTitle>
					<div className="flex items-center gap-3">
						<Button
							variant="outline"
							size="sm"
							onClick={() => setIsAddingRemark(!isAddingRemark)}
						>
							{isAddingRemark ? "Cancel" : "Add Remark"}
						</Button>

						{latestRemarks && latestRemarks.length >= 1 && (
							<Button variant="outline" size="sm" asChild>
								<Link href={`/citizens/${citizenId}/remarks`}>
									View All Remarks
									<ArrowRight className="ml-2 h-4 w-4" />
								</Link>
							</Button>
						)}
					</div>
				</div>
				<CardDescription className="max-w-sm">
					All remarks are attached to the license, so you will see these on any related
					characters.
				</CardDescription>
			</CardHeader>
			<CardContent>
				{isAddingRemark && (
					<div className="mb-4">
						<form onSubmit={handleAddRemark} className="space-y-3">
							<Textarea
								placeholder="Add a new remark..."
								value={newRemark}
								onChange={(e) => setNewRemark(e.target.value)}
								className="min-h-[120px]"
							/>
							<div className="flex justify-end gap-2">
								<Button
									type="button"
									variant="outline"
									onClick={() => setIsAddingRemark(false)}
								>
									Cancel
								</Button>
								<Button type="submit">Save Remark</Button>
							</div>
						</form>
						<Separator className="my-4" />
					</div>
				)}

				{/* Latest 3 remarks */}
				<div className="space-y-4">
					{!latestRemarks || latestRemarks.length === 0 ? (
						<div className="flex items-center justify-center h-24 text-muted-foreground">
							No remarks found
						</div>
					) : (
						latestRemarks.map((remark) => (
							<div
								key={remark.id}
								className="space-y-2 border-l-2 border-primary pl-3 pb-3"
							>
								<p className="text-sm line-clamp-2">
									{formattedText(remark.content)}
								</p>
								<div className="flex items-center justify-between text-xs text-muted-foreground">
									<span>{remark.remarkingUserName}</span>
									<span>{formatDateTime(remark.created)}</span>
								</div>
							</div>
						))
					)}
				</div>
			</CardContent>
		</Card>
	);
}
