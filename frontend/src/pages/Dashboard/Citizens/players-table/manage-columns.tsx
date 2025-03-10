import { Button } from "@/components/ui/button";
import {
	Command,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
} from "@/components/ui/command";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { playersTableColumnsAtom } from "@/lib/state/pages/players";
import { cn, getNestedValue, isStringNumber } from "@/lib/utils";
import { TPlayer } from "@/types";
import { ColumnDef } from "@tanstack/react-table";
import { useAtom } from "jotai";
import { Check, Settings } from "lucide-react";
import { PlayersDefaultColumns } from "./players-default-columns";
import PlayerTableHeader from "./table-header";
import { PlayerColumn } from "../configs/allowed-columns";
import useSWR from "swr";
import { ApiEndponts } from "@/lib/config";
import { TableColumn } from "@/types/api/table-columns";

export default function ManagePlayersTableColumns() {
	const [columns, setColumns] = useAtom(playersTableColumnsAtom);

	const { data, isLoading } = useSWR<TableColumn[]>(ApiEndponts.TableColumns.Get("PLAYERS"));

	function onColumnClick({ tableKey, valuePath, friendlyName }: TableColumn) {
		const isActiveColumn = columns.find((c) => c.id === valuePath);

		if (isActiveColumn) {
			setColumns(columns.filter((c) => c.id !== valuePath));
			return;
		}

		const defaultColumn = PlayersDefaultColumns.find((_c) => _c.id === valuePath);

		const column: ColumnDef<TPlayer> = {
			id: valuePath,
			header: (props) => <PlayerTableHeader title={friendlyName || valuePath} {...props} />,
			size: 200,
			cell: ({ row }) => {
				let rowData = getNestedValue<any>(row.original, valuePath);

				return isStringNumber(rowData) ? <code>{rowData}</code> : <span>{rowData}</span>;
			},
		};

		setColumns([...columns, defaultColumn ? defaultColumn : column]);
	}

	return (
		<Popover>
			<PopoverTrigger asChild>
				<Button variant={"outline"} size={"sm"}>
					<Settings /> Manage Columns
				</Button>
			</PopoverTrigger>
			<PopoverContent align="end" className="p-0">
				<Command>
					<CommandInput placeholder="Search Columns" />
					<CommandList>
						<CommandGroup>
							{data &&
								Array.isArray(data) &&
								data.map((c) => {
									const isActive = columns.find((_c) => _c.id === c.valuePath);

									return (
										<CommandItem
											key={c.valuePath}
											onSelect={() => onColumnClick(c)}
										>
											<Check
												className={cn(
													isActive ? "opacity-100" : "opacity-0"
												)}
											/>
											<span>{c.friendlyName || c.valuePath}</span>
										</CommandItem>
									);
								})}
						</CommandGroup>
					</CommandList>
				</Command>
			</PopoverContent>
		</Popover>
	);
}
