import DashboardLayout from "@/components/layouts/Dashboard";
import LogsSearchBar from "./filter-bar";
import { useAtom, useSetAtom } from "jotai";
import { logsAtom, logSearchFilterAtom, logTimerangeFilterAtom } from "@/lib/state/pages/logs";
import { useEffect, useState } from "react";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TPagination } from "@/types/api/pagination";
import { TLog } from "@/types/api/logs";
import LogsTable from "./log-table";
import { useLocation } from "wouter";
import { toQuery } from "@/lib/utils";
import { useAuth, useSearchParam } from "@/hooks";
import { SearchFilterSchema, TSearchFilter } from "@/types/logs";
import { z } from "zod";
import LogDetails from "./log-details";
import { getLocalTimeZone, CalendarDate } from "@internationalized/date";
import Pagination from "./pagination";

export const searchFilterArraySchema = z.array(SearchFilterSchema);
const dateSchema = z.date();

export default function LogsPage() {
	// Used to prevent double searching while reading query filters.
	const [isPageLoading, setIsPageLoading] = useState<boolean>(true);
	const [totalPages, setTotalPages] = useState<number>(0);

	const { hasPermission, isPermissionsReady } = useAuth();

	// Pull search params from query.
	const queryFilters = useSearchParam("filters");
	const queryStart = useSearchParam("startTime");
	const queryEnd = useSearchParam("endTime");
	const queryPage = useSearchParam("page");
	const [__, setLocation] = useLocation();

	// Atoms for data storage
	const setData = useSetAtom(logsAtom);
	const [filters, setFilters] = useAtom(logSearchFilterAtom);
	const [timerange, setTimerange] = useAtom(logTimerangeFilterAtom);

	useEffect(() => {
		if (isPageLoading) return;

		let body: Record<string, any> = {
			filters: filters.map((f) => ({
				key: f.key,
				operator: f.method,
				value: f.value,
			})),
			size: 11,
			page: queryPage || 1,
		};

		if (timerange !== null) {
			body = {
				...body,
				startTime: timerange.start.toDate(getLocalTimeZone()),
				endTime: timerange.end.toDate(getLocalTimeZone()),
			};
		}

		Fetch.Post<TPagination<TLog>>(ApiEndponts.Logs.Search, {
			body: body,
			includeCredentials: true,
		}).then((r) => {
			setData(r.data?.items || []);
			setTotalPages(r.data?.totalPages || 1);
		});
	}, [filters, isPageLoading, timerange, queryPage]);

	useEffect(() => {
		if (isPageLoading) return;

		console.log(filters.length);

		const queryString = toQuery({
			filters: filters.length >= 0 ? JSON.stringify(filters) : "",
			startTime: timerange ? timerange.start.toDate(getLocalTimeZone()).toISOString() : "",
			endTime: timerange ? timerange.end.toDate(getLocalTimeZone()).toISOString() : "",
		});

		if (queryString) {
			setLocation(`/logs?${queryString}`);
		}
	}, [filters, isPageLoading, timerange]);

	useEffect(() => {
		if (isPageLoading) {
			if (queryFilters) {
				const safeData = searchFilterArraySchema.safeParse(JSON.parse(queryFilters));

				if (safeData.success) {
					setFilters(safeData.data as TSearchFilter[]);
				}
			}

			if (queryStart && queryEnd) {
				const safeStartDate = dateSchema.safeParse(new Date(queryStart));
				const safeEndDate = dateSchema.safeParse(new Date(queryEnd));

				console.log(safeStartDate, safeEndDate);

				if (!safeStartDate.success || !safeEndDate.success) return;

				setTimerange({
					start: new CalendarDate(
						safeStartDate.data.getFullYear(),
						safeStartDate.data.getMonth() + 1,
						safeStartDate.data.getDate()
					),
					end: new CalendarDate(
						safeEndDate.data.getFullYear(),
						safeEndDate.data.getMonth() + 1,
						safeEndDate.data.getDate()
					),
				});
			}

			setIsPageLoading(false);
		} else {
			setIsPageLoading(false);
		}
	}, [queryFilters, isPageLoading, queryStart, queryEnd]);

	if (!isPermissionsReady) return "permissions not ready";
	if (isPermissionsReady && !hasPermission([Permissions.ViewLogs])) {
		setLocation("/");
		return;
	}

	return (
		<DashboardLayout>
			<div>
				<div className="p-5">
					<h1 className="text-lg font-semibold">Server Logs</h1>
					<p className="text-sm text-muted-foreground">
						View and filter through all server logs. Utlize the add filter to fine tune
						the logs your looking for. Use the time range button to filter down to a
						given amount of time.
					</p>
				</div>
				<hr className="w-full" />
				{!isPageLoading && (
					<div className="p-5 pt-0">
						<LogsSearchBar />
						<LogsTable />
						<Pagination totalPages={totalPages} />
						<LogDetails />
					</div>
				)}
			</div>
		</DashboardLayout>
	);
}
