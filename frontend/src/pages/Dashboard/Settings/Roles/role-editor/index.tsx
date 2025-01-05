import { ApiEndponts } from "@/lib/config";
import useSWR from "swr";

export default function RoleEditor(props: { roleKey: string }) {
	const { data: activeRolePermissions } = useSWR<string[]>(
		props.roleKey && ApiEndponts.Roles.GetPermissions(props.roleKey)
	);

	const { data: permissions } = useSWR<{ key: string }[]>(
		props.roleKey && ApiEndponts.Permissions.Get
	);

	return (
		<div>
			<pre>{JSON.stringify(permissions, null, 2)}</pre>
		</div>
	);
}
