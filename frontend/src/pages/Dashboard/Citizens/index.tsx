import DashboardLayout from "@/components/layouts/Dashboard";
import PlayersHeader from "./header";
import { useEffect } from "react";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TPagination, TPlayer } from "@/types";
import { useAtom } from "jotai";
import { playersAtom, totalPlayerPagesAtom } from "@/lib/state/pages/players";
import PlayersTable from "./players-table";
import { useAuth, useSearchParam } from "@/hooks";
import PlayersFilters from "./filters";
import { searchFilterArraySchema } from "../Logs";
import Pagination from "./pagination";
import { useLocation } from "wouter";

export default function PlayersPage() {
	const [_, setPlayers] = useAtom(playersAtom);
	const [__, setTotalPages] = useAtom(totalPlayerPagesAtom);

	const [___, setLocation] = useLocation();

	const { hasPermission, isPermissionsReady } = useAuth();

	const sortBy = useSearchParam("sortBy");
	const sortOrder = useSearchParam("sortOrder");
	const filters = useSearchParam("filters");
	const page = useSearchParam("page");

	useEffect(() => {
		const safeFilters = searchFilterArraySchema.safeParse(JSON.parse(filters || "[]"));

		Fetch.Post<TPagination<TPlayer>>(ApiEndponts.Citizens.Search, {
			includeCredentials: true,
			body: {
				filters: safeFilters.success
					? safeFilters.data.map((f) => ({
							key: f.key,
							operator: f.method,
							value: f.value,
					  }))
					: [],
				sortBy,
				sortOrder,
				size: 11,
				page: page && !isNaN(parseInt(page)) ? parseInt(page) : 1,
			},
		}).then((r) => {
			if (!r.data) return;
			setPlayers(r.data.items);
			setTotalPages(r.data.totalPages);
		});
	}, [sortBy, sortOrder, filters, page]);

	if (!isPermissionsReady) return "permissions not ready";
	if (!hasPermission([Permissions.ViewPlayers])) {
		setLocation("/");
		return;
	}

	return (
		<DashboardLayout>
			<PlayersHeader />
			<hr />
			<PlayersFilters />
			<PlayersTable />
			<div className="px-5">
				<Pagination />
			</div>
		</DashboardLayout>
	);
}
