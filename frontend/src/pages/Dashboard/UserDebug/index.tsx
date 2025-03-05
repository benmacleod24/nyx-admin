import DashboardLayout from "@/components/layouts/Dashboard";
import { permissionKeysAtom, permissionsAtom } from "@/lib/state/permissions";
import { userAtom } from "@/lib/state/user";
import { useAtomValue } from "jotai";

export default function UserDebugPage() {
	const user = useAtomValue(userAtom);
	const permissions = useAtomValue(permissionsAtom);
	const permissionKeys = useAtomValue(permissionKeysAtom);

	if (process.env.NODE_ENV !== "development") {
		return;
	}

	return (
		<DashboardLayout className="p-5">
			<div>
				<h1 className="text-xl font-semibold">User Debug</h1>
				<p className="text-sm text-muted-foreground">
					You really shouldn't be able to get here in production.
				</p>
			</div>
			<div className="grid grid-cols-3 w-full gap-3">
				<div className="bg-muted rounded-lg border shadow p-3 h-fit max-h-[50rem] border-muted-foreground mt-5 w-full overflow-auto">
					<pre>{JSON.stringify(user, null, 2)}</pre>
				</div>
				<div className="bg-muted rounded-lg border shadow p-3 border-muted-foreground h-fit max-h-[50rem] mt-5 w-full overflow-auto">
					<pre>{JSON.stringify(permissions, null, 2)}</pre>
				</div>
				<div className="bg-muted rounded-lg border shadow p-3 border-muted-foreground h-fit max-h-[50rem] mt-5 w-full overflow-auto">
					<pre>{JSON.stringify(permissionKeys, null, 2)}</pre>
				</div>
			</div>
		</DashboardLayout>
	);
}
