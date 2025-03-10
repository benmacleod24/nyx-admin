import { TPlayer } from "@/types";
import { ColumnDef } from "@tanstack/react-table";
import PlayerTableHeader from "./table-header";

export const PlayersDefaultColumns: ColumnDef<TPlayer>[] = [
	{
		id: "citizenId",
		accessorKey: "citizenId",
		header: (props) => <PlayerTableHeader disableSizing title="Citizen ID" {...props} />,
		cell: ({ row }) => <code>{row.original.citizenId}</code>,
		maxSize: 130,
		minSize: 130,
	},
	{
		id: "charInfo.firstname",
		header: (props) => <PlayerTableHeader title="First Name" {...props} />,
		cell: ({ row }) => <span className="capitalize">{row.original.charInfo.firstname}</span>,
	},
	{
		id: "charInfo.lastname",
		header: (props) => <PlayerTableHeader title="Last Name" {...props} />,
		cell: ({ row }) => <span className="capitalize">{row.original.charInfo.lastname}</span>,
	},
	{
		id: "name",
		header: (props) => <PlayerTableHeader sortKey="name" title="Played By" {...props} />,
		cell: ({ row }) => <span>{row.original.name}</span>,
	},
	{
		id: "license",
		minSize: 330,
		header: (props) => <PlayerTableHeader disableSizing title="License" {...props} />,
		cell: ({ row }) => <code>{row.original.license.split(":")[1]}</code>,
	},
];
