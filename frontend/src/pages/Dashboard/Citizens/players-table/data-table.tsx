import { ColumnDef, flexRender, getCoreRowModel, useReactTable } from "@tanstack/react-table";

import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { Link } from "wouter";
import { TPlayer } from "@/types";

interface DataTableProps<TData, TValue> {
	columns: ColumnDef<TData, TValue>[];
	data: TData[];
}

export default function PlayerDataTable<TData, TValue>({
	columns,
	data,
}: DataTableProps<TData, TValue>) {
	const table = useReactTable({
		data,
		columns,
		getCoreRowModel: getCoreRowModel(),
		state: {
			columnPinning: {
				left: ["citizenId", "name", "charInfo.firstname", "charInfo.lastname"],
				right: ["license"],
			},
		},
	});

	return (
		<Table className="grid border-separate border-spacing-0">
			<TableHeader className="grid">
				{table.getHeaderGroups().map((headerGroup) => (
					<TableRow
						key={headerGroup.id}
						className="flex w-full hover:bg-transparent"
						style={{ borderBottom: "none" }}
					>
						{headerGroup.headers.map((header) => {
							return (
								<TableHead
									key={header.id}
									style={{ width: `${header.getSize()}px` }}
									className="flex bg-muted/50 items-center first:rounded-l-lg first:border-l border-y last:border-r last:rounded-r-lg last:flex-grow"
								>
									{header.isPlaceholder
										? null
										: flexRender(
												header.column.columnDef.header,
												header.getContext()
										  )}
								</TableHead>
							);
						})}
					</TableRow>
				))}
			</TableHeader>
			<TableBody className="grid mt-1">
				{table.getRowModel().rows?.length ? (
					table.getRowModel().rows.map((row) => (
						<Link
							key={row.id}
							href={`/citizens/${(row.original as TPlayer).citizenId}`}
						>
							<TableRow
								data-state={row.getIsSelected() && "selected"}
								className="flex rounded-lg"
							>
								{row.getVisibleCells().map((cell) => (
									<TableCell
										key={cell.id}
										className="overflow-hidden cursor-pointer"
										style={{
											width: `${cell.column.getSize()}px`,
										}}
									>
										{flexRender(cell.column.columnDef.cell, cell.getContext())}
									</TableCell>
								))}
							</TableRow>
						</Link>
					))
				) : (
					<TableRow>
						<TableCell colSpan={columns.length} className="h-24 text-center">
							No results.
						</TableCell>
					</TableRow>
				)}
			</TableBody>
		</Table>
	);
}
