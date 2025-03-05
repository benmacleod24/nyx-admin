/**
 * Because the column system for the players table is dynamic based on
 * the json data provided. We need a way for admins to add these column paths
 * into the json.
 */
export default function PlayerColumnsSettings() {
	return (
		<div className="p-10">
			<div>
				<h1 className="text-lg font-semibold">Player Table Columns</h1>
				<p className="text-sm text-muted-foreground">
					Manage the columns available in the players table.
				</p>
			</div>
		</div>
	);
}
