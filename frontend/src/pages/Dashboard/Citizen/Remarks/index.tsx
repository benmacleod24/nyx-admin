import DashboardLayout from "@/components/layouts/Dashboard";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useDebounce } from "@/components/ui/multi-select";
import { Separator } from "@/components/ui/separator";
import { useAuth, useSearchParams } from "@/hooks";
import { ApiEndponts, Permissions } from "@/lib/config";
import { formatDateTime, toQuery } from "@/lib/utils";
import { TRemark } from "@/types/api/remarks";
import { ArrowLeft, Loader, MessageSquare, Search } from "lucide-react";
import { useEffect, useMemo, useRef, useState } from "react";
import useSWR from "swr";
import { Link, useLocation, useParams } from "wouter";
import CitizenRemarksPagination from "./pagination";
import { TPagination } from "@/types";
import React from "react";

export default function CitizenRemarksPage() {
	const { id } = useParams<{ id: string }>();
	const params = useSearchParams<{ where: string; page: string }>();
	const [_, setLocation] = useLocation();
	const { hasPermission } = useAuth();

	const [search, setSearch] = useState<string>(params.where || "");
	const debouncedSearch = useDebounce(search, 500);

	const { data, isLoading } = useSWR<TPagination<TRemark>>(
		ApiEndponts.Remarks.GetByCitizenId(id) +
			`?${toQuery({
				page: params.page && !isNaN(parseInt(params.page)) ? params.page : "1",
				size: "2",
				where: encodeURIComponent(params.where || ""),
			})}`
	);

	const isFirstRender = useRef(true);

	useEffect(() => {
		if (isFirstRender.current) {
			isFirstRender.current = false;
			return;
		}

		setLocation(
			`/citizens/${id}/remarks?${toQuery({
				...params,
				where: encodeURIComponent(debouncedSearch),
				page: "1",
			})}`
		);
	}, [debouncedSearch]);

	const groupedByMonth = useMemo(() => {
		const grouped: Record<string, TRemark[]> = {};

		if (!data || !data.items) return grouped;

		data.items.forEach((remark) => {
			const date = new Date(remark.created);
			const monthYear = date.toLocaleString("en-US", { month: "long", year: "numeric" });

			if (!grouped[monthYear]) {
				grouped[monthYear] = [];
			}

			grouped[monthYear].push(remark);
		});

		return grouped;
	}, [data]);

	if (isLoading) {
		return (
			<DashboardLayout>
				<Loader className="text-brand animate-spin" />
			</DashboardLayout>
		);
	}

	if (!hasPermission([Permissions.ViewPlayerRemarks])) {
		setLocation("/");
		return;
	}

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
		<DashboardLayout>
			<div className="max-w-7xl mx-auto mt-7">
				<div>
					{/* Back button and header */}
					<div className="mb-6 flex items-center justify-between">
						<Button variant="outline" size="sm" asChild>
							<Link href={`/citizens/${id}`}>
								<ArrowLeft className="mr-2 h-4 w-4" />
								Back to Citizen Profile
							</Link>
						</Button>
					</div>

					{/* Page header */}
					<div className="mb-6">
						<h1 className="text-2xl font-bold flex items-center">
							<MessageSquare className="mr-2 h-6 w-6 mt-1 text-brand" />
							All Remarks
						</h1>
						<p className="text-muted-foreground mt-1">
							Complete history of admin notes and observations
						</p>
					</div>

					{/* Search */}
					<div className="mb-6 relative max-w-md">
						<Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
						<Input
							value={search}
							onChange={(e) => setSearch(e.target.value)}
							placeholder="Search Remarks"
							className="pl-8"
						/>
					</div>
				</div>
				<Separator className="my-6" />

				{data && data.items && data.items.length <= 0 ? (
					<div className="flex items-center justify-center h-64 text-muted-foreground">
						No Remarks Found
					</div>
				) : (
					<div className="space-y-6 mb-8">
						{Object.entries(groupedByMonth).map(([monthYear, monthRemarks]) => (
							<div key={monthYear} className="space-y-4">
								<h3 className="text-sm font-semibold text-muted-foreground sticky top-0 bg-background py-1">
									{monthYear}
								</h3>
								{monthRemarks.map((remark) => (
									<div
										key={remark.id}
										className="space-y-2 border-l-2 border-primary pl-3 pb-4"
									>
										<p className="text-sm">{formattedText(remark.content)}</p>
										<div className="flex items-center justify-between text-xs text-muted-foreground">
											<span>{remark.remarkingUserName}</span>
											<span>{formatDateTime(remark.created)}</span>
										</div>
									</div>
								))}
							</div>
						))}

						<CitizenRemarksPagination totalPages={data!.totalPages || 0} />
					</div>
				)}
			</div>
		</DashboardLayout>
	);
}
