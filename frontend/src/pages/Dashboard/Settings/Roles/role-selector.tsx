import { cn } from "@/lib/utils";
import { TRole } from "@/types";
import { GripVertical } from "lucide-react";
import CreateRole from "./create-role";

export default function RoleSelector(props: {
	roles: TRole[];
	setEditingRole: (key: string) => void;
	editingRoleKey: string;
}) {
	return (
		<div className="max-w-[13rem] grid gap-2">
			{props.roles.map((r) => (
				<div
					key={r.id}
					onClick={() => props.setEditingRole(r.key)}
					className={cn(
						"border select-none  rounded-lg hover:bg-muted cursor-move flex items-center gap-2 px-2 py-1.5 w-full",
						props.editingRoleKey === r.key && "bg-muted"
					)}
				>
					<GripVertical className="text-muted-foreground" size={15} />
					<h1 className="truncate">{r.friendlyName}</h1>
				</div>
			))}
		</div>
	);
}
