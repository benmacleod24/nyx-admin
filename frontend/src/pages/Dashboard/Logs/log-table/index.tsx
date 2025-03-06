import { useAtom } from "jotai";
import { DataTable } from "./data-table";
import { logColumnsAtom, logsAtom } from "@/lib/state/pages/logs";
import { logColumns } from "./columns";

export default function LogsTable() {
	const [logs, setLogs] = useAtom(logsAtom);
	const [columns, setColumns] = useAtom(logColumnsAtom);

	return (
		<div>
			<DataTable data={logs} columns={columns} />
		</div>
	);
}
