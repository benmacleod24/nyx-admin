import { Button } from "@/components/ui/button";
import { logColumnsAtom } from "@/lib/state/pages/logs";
import { useAtom } from "jotai";
import { BetweenVerticalStart } from "lucide-react";
import { logColumns } from "../log-table/columns";
import useSWR from "swr";
import { ApiEndponts } from "@/lib/config";
import {
	Command,
	CommandEmpty,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
} from "@/components/ui/command";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { capitalize, toFlatCase } from "@/lib/utils";
import { useMemo } from "react";
import { ColumnDef } from "@tanstack/react-table";
import { TLog } from "@/types/api/logs";
import ColumnHeader from "../log-table/column-header";

export default function AddColumns() {
	const [columns, setColumns] = useAtom(logColumnsAtom);
	const { data, isLoading } = useSWR<string[]>(ApiEndponts.Logs.MetadataKeys);

	function addColumn(columnId: string) {
		const isDefaultColumn = logColumns.find((c) => c.id === columnId);
		const isActiveColumn = columns.find((c) => c.id === columnId);

		if (isActiveColumn) return;

		// Add default column.
		if (isDefaultColumn) {
			setColumns([...columns, isDefaultColumn]);
			return;
		}

		const column: ColumnDef<TLog> = {
			id: columnId,
			accessorKey: "metadata",
			header: (props) => <ColumnHeader {...props} title={capitalize(toFlatCase(columnId))} />,
			cell: (props) => {
				const metadata = props.row.original.metadata;
				const value = metadata[columnId];

				if (!metadata[columnId])
					return (
						<div>
							<code className="text-muted-foreground/50">N/A</code>
						</div>
					);

				return <div>{typeof value === "object" ? JSON.stringify(value) : value}</div>;
			},
		};

		setColumns([...columns, column]);
	}

	const columnOptions = useMemo(() => {
		let options: string[] = ["timestamp", "level", "message"];

		if (data && Array.isArray(data)) {
			options = [...options, ...data];
		}

		return options.filter((c) => !columns.find((_c) => _c.id === c));
	}, [data, columns]);

	return (
		<Popover>
			<PopoverTrigger asChild>
				<Button
					disabled={!data || !Array.isArray(data) || isLoading}
					className="rounded-full select-none data-[state=open]:bg-muted"
					size={"sm"}
					variant={"outline"}
				>
					<BetweenVerticalStart />
					Add Column
				</Button>
			</PopoverTrigger>
			<PopoverContent align="start" className="p-0">
				<Command>
					<CommandInput placeholder="Search Columns" />
					<CommandList>
						<CommandEmpty />
						<CommandGroup>
							{columnOptions.map((key) => (
								<CommandItem
									key={key}
									value={key}
									onSelect={() => addColumn(key)}
									className="capitalize"
								>
									{toFlatCase(key)}
								</CommandItem>
							))}
						</CommandGroup>
					</CommandList>
				</Command>
			</PopoverContent>
		</Popover>
	);
}
