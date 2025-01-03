import { ApiEndponts } from "@/lib/config";
import useSWR from "swr";

export default function RoleEditor(props: { roleKey: string }) {
	const { data } = useSWR<string[]>(
		props.roleKey && ApiEndponts.Roles.GetPermissions(props.roleKey)
	);

	return (
		<div>
			<pre>{JSON.stringify(data, null, 2)}</pre>
		</div>
	);
}
