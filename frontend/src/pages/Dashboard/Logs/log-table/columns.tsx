import { TLog } from "@/types/api/logs";
import { ColumnDef } from "@tanstack/react-table";

import ColumnHeader from "./column-header";
import dayjs from "dayjs";
import LevelBadge from "./level-badge";

export const logColumns: ColumnDef<TLog>[] = [
	{
		id: "timestamp",
		accessorKey: "createdAt",
		maxSize: 150,
		minSize: 150,
		header: (props) => <ColumnHeader {...props} disableSizing title="Timestamp" />,
		cell: ({ row }) => {
			const value = row.original.createdAt;
			return <span>{dayjs(value).format("MMM, DD HH:mm:ss")}</span>;
		},
	},
	{
		id: "level",
		minSize: 100,
		maxSize: 120,
		accessorKey: "level",
		header: (props) => <ColumnHeader {...props} disableSizing title="Level" />,
		cell: ({ row }) => <LevelBadge level={row.original.level} />,
	},
	{
		id: "message",
		accessorKey: "message",
		header: (props) => <ColumnHeader {...props} title="Message" />,
	},
];
