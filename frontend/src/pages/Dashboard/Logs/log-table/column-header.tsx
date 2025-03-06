import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuItem,
	DropdownMenuLabel,
	DropdownMenuSeparator,
	DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { logColumnsAtom } from "@/lib/state/pages/logs";
import { TLog } from "@/types/api/logs";
import { HeaderContext } from "@tanstack/react-table";
import { useAtom } from "jotai";
import { ChevronDown, Minus, Plus, Trash2 } from "lucide-react";

export type ColumnHeader = HeaderContext<TLog, unknown> & {
	title: string;
	disableSizing?: boolean;
};

export default function ColumnHeader(props: ColumnHeader) {
	const [columns, setColumns] = useAtom(logColumnsAtom);

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

	return (
		<DropdownMenu>
			<DropdownMenuTrigger className="flex items-center gap-2 group select-none focus-visible:outline-0 w-full">
				<span className="line-clamp-1">{props.title}</span>
				<ChevronDown
					size={18}
					className="mt-1 opacity-0 group-hover:opacity-100 transition-all group-data-[state=open]:opacity-100"
				/>
			</DropdownMenuTrigger>
			<DropdownMenuContent align="start">
				{!props.disableSizing && (
					<>
						{" "}
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
