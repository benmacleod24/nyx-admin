import DashboardLayout from "@/components/layouts/Dashboard";
import PlayersHeader from "./header";
import { useEffect } from "react";
import { Fetch } from "@/lib";
import { ApiEndponts } from "@/lib/config";
import { TPagination, TPlayer } from "@/types";
import { useAtom } from "jotai";
import { playersAtom, totalPlayerPagesAtom } from "@/lib/state/pages/players";
import PlayersTable from "./players-table";
import { useSearchParam } from "@/hooks";
import PlayersFilters from "./filters";
import { searchFilterArraySchema } from "../Logs";
import Pagination from "./pagination";

export default function PlayersPage() {
	const [_, setPlayers] = useAtom(playersAtom);
	const [__, setTotalPages] = useAtom(totalPlayerPagesAtom);

	const sortBy = useSearchParam("sortBy");
	const sortOrder = useSearchParam("sortOrder");
	const filters = useSearchParam("filters");
	const page = useSearchParam("page");

	useEffect(() => {
		const safeFilters = searchFilterArraySchema.safeParse(JSON.parse(filters || "[]"));

		Fetch.Post<TPagination<TPlayer>>(ApiEndponts.Players.Search, {
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
