import ManagePlayersTableColumns from "./players-table/manage-columns";

export default function PlayersHeader() {
	return (
		<div className="p-5 flex items-center justify-between">
			<div>
				<h1 className="text-lg font-semibold">Players Database</h1>
				<p className="text-sm text-muted-foreground">
					Look up and filter through all characters (players) within the server.
				</p>
			</div>
			<div>
				<ManagePlayersTableColumns />
			</div>
		</div>
	);
}
