import { ColumnDef, flexRender, getCoreRowModel, useReactTable } from "@tanstack/react-table";
import {
	Table,
	TableBody,
	TableCell,
	TableHead,
	TableHeader,
	TableRow,
} from "@/components/ui/table";
import { cn, toQuery } from "@/lib/utils";
import { useLocation } from "wouter";
import { TLog } from "@/types/api/logs";
import { useSearchParams } from "@/hooks";

interface DataTableProps<TData, TValue> {
	columns: ColumnDef<TData, TValue>[];
	data: TData[];
}

export function DataTable<TData, TValue>({ columns, data }: DataTableProps<TData, TValue>) {
	const [_, setLocation] = useLocation();
	const searchParams = useSearchParams();

	const table = useReactTable({
		data,
		columns,
		getCoreRowModel: getCoreRowModel(),
		defaultColumn: {
			size: 200,
		},
		state: {
			columnPinning: {
				left: ["timestamp", "level"],
				right: ["message", "viewMore"],
			},
		},
	});

	return (
		<div className="rounded-md w-full">
			<Table className="grid w-full border-separate border-spacing-0">
				<TableHeader className="grid w-full border-0">
					{table.getHeaderGroups().map((headerGroup) => (
						<TableRow
							key={headerGroup.id}
							className="flex w-full"
							style={{ border: "none" }}
						>
							{headerGroup.headers.map((header) => {
								return (
									<TableHead
										key={header.id}
										style={{ width: `${header.getSize()}px` }}
										className={cn(
											"flex bg-muted/50 border-y first:border-l last:border-r first:rounded-l-lg last:rounded-r-lg",
											header.column.id === "message" && "flex-grow"
										)}
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
							<TableRow
								key={row.id}
								data-state={row.getIsSelected() && "selected"}
								className="flex cursor-pointer rounded-lg border-0"
								onClick={() =>
									setLocation(
										`/logs?${toQuery({
											...searchParams,
											logId: (row.original as TLog).id.toString(),
										})}`
									)
								}
							>
								{row.getVisibleCells().map((cell) => {
									return (
										<TableCell
											key={cell.id}
											style={{
												width: `${cell.column.getSize()}px`,
											}}
											className={cn(
												cell.column.id === "message" && "flex-grow"
											)}
										>
											{flexRender(
												cell.column.columnDef.cell,
												cell.getContext()
											)}
										</TableCell>
									);
								})}
							</TableRow>
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
		</div>
	);
}
