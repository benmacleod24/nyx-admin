import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useSearchParams } from "@/hooks";
import { playersTableColumnsAtom } from "@/lib/state/pages/players";
import { toQuery } from "@/lib/utils";
import { TPlayer } from "@/types";
import { HeaderContext } from "@tanstack/react-table";
import { useAtom } from "jotai";
import { ArrowDown, ArrowUp, ChevronDown, Minus, Plus, Trash2 } from "lucide-react";
import { useLocation } from "wouter";

type ColumnHeader = HeaderContext<TPlayer, unknown> & {
	title: string;
	disableSizing?: boolean;
	sortKey?: string;
};

export default function PlayerTableHeader(props: ColumnHeader) {
	const [columns, setColumns] = useAtom(playersTableColumnsAtom);

	const [_, setLocation] = useLocation();
	const searchParams = useSearchParams<{ sortBy: string; sortOrder: string }>();

	function increaseWidth() {
		if (props.disableSizing) return;
		const newCols = [...columns];
		const columnIdx = newCols.findIndex((c) => c.id === props.column.id);

		if (columnIdx >= 0) {
			newCols[columnIdx].size = props.column.getSize() + 30;
			setColumns(newCols);
		}
	}

	function decreaseWidth() {
		if (props.disableSizing) return;
		const newCols = [...columns];
		const columnIdx = newCols.findIndex((c) => c.id === props.column.id);

		if (columnIdx >= 0) {
			newCols[columnIdx].size = props.column.getSize() - 30;
			setColumns(newCols);
		}
	}

	function removeColumn() {
		setColumns(columns.filter((c) => c.id !== props.column.id));
	}

	function sortByAscending() {
		setLocation(
			`/citizens?${toQuery({
				...searchParams,
				sortBy: props.sortKey || props.column.id,
				sortOrder: "asc",
			})}`
		);
	}

	function sortByDescending() {
		setLocation(
			`/citizens?${toQuery({
				...searchParams,
				sortBy: props.sortKey || props.column.id,
				sortOrder: "desc",
			})}`
		);
	}

	return (
		<DropdownMenu>
			<DropdownMenuTrigger className="flex items-center gap-2 group select-none focus-visible:outline-0 w-full">
				<span className="line-clamp-1">{props.title}</span>
				{(searchParams.sortBy && searchParams.sortBy === props.sortKey) ||
				searchParams.sortBy === props.column.id ? (
					searchParams.sortOrder === "desc" ? (
						<ArrowDown size={18} />
					) : (
						<ArrowUp size={18} />
					)
				) : (
					<ChevronDown
						size={18}
						className="mt-1 opacity-0 group-hover:opacity-100 transition-all group-data-[state=open]:opacity-100"
					/>
				)}
			</DropdownMenuTrigger>
			<DropdownMenuContent align="start">
				<DropdownMenuItem onClick={sortByAscending}>
					<ArrowUp /> Sort By Ascending
				</DropdownMenuItem>
				<DropdownMenuItem onClick={sortByDescending}>
					<ArrowDown /> Sort By Descending
				</DropdownMenuItem>
				{!props.disableSizing && (
					<>
						<DropdownMenuItem onClick={increaseWidth}>
							<Plus /> Increase Width
						</DropdownMenuItem>
						<DropdownMenuItem onClick={decreaseWidth}>
							<Minus /> Decrease Width
						</DropdownMenuItem>
					</>
				)}
				<DropdownMenuItem onClick={removeColumn}>
					<Trash2 className="text-red-300" /> Remove
				</DropdownMenuItem>
			</DropdownMenuContent>
		</DropdownMenu>
	);
}
