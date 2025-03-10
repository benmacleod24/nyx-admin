import { playersAtom, playersTableColumnsAtom } from "@/lib/state/pages/players";
import { useAtomValue } from "jotai";
import PlayerDataTable from "./data-table";

export default function PlayersTable() {
	const players = useAtomValue(playersAtom);
	const columns = useAtomValue(playersTableColumnsAtom);

	return (
		<div className="p-5">
			<PlayerDataTable data={players} columns={columns} />
		</div>
	);
}
