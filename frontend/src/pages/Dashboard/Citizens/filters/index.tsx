import { useSearchParam, useSearchParams } from "@/hooks";
import AddPlayersFilter from "./add-filter";
import { searchFilterArraySchema } from "../../Logs";
import { toQuery } from "@/lib/utils";
import { useLocation } from "wouter";
import { XCircle } from "lucide-react";
import { playersSearchFilter } from "../configs/search-filters";
import useSWR from "swr";
import { ApiEndponts } from "@/lib/config";
import { TableColumn } from "@/types/api/table-columns";

export default function PlayersFilters() {
	const filters = useSearchParam("filters");
	const _filters = searchFilterArraySchema.safeParse(JSON.parse(filters || "[]"));

	const { data: tableColumns } = useSWR<TableColumn[]>(ApiEndponts.TableColumns.Get("PLAYERS"));

	const searchParams = useSearchParams();
	const [_, setLocation] = useLocation();

	function removeFilter(filterIndex: number) {
		if (!_filters.success) return;

		const newFilters = _filters.data.filter((_, index) => index !== filterIndex);
		setLocation(
			`/citizens?${toQuery({ ...searchParams, filters: JSON.stringify(newFilters) })}`
		);
	}

	if (!tableColumns) return;

	return (
		<div className="p-5 pb-0 flex gap-2 flex-wrap items-center">
			{_filters.success &&
				Array.isArray(_filters.data) &&
				_filters.data.map((f, index) => {
					const filter = tableColumns.find((_f) => _f.valuePath === f.key);

					if (!filter) return;

					return (
						<div
							key={f.value}
							className="rounded-lg overflow-hidden border border-brand bg-brand/20 text-sm text-brand px-3 h-9 flex items-center justify-center gap-1"
						>
							<span className="font-semibold">
								{filter.friendlyName || filter.valuePath}
							</span>
							<span className="italic">{f.method}</span>
							<span className="text-mono">"{f.value}"</span>
							<XCircle
								size={16}
								onClick={() => removeFilter(index)}
								className="ml-1 cursor-pointer hover:text-white transition-colors"
							/>
						</div>
					);
				})}
			<AddPlayersFilter tableColumns={tableColumns} />
		</div>
	);
}
