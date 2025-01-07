import { Avatar, AvatarImage } from "@/components/ui/avatar";
import SearchInput from "@/components/ui/search-input";
import { useAuth } from "@/hooks";
import {
	editingUserAtom,
	shouldAniamteUnsavedUserChangesAtom,
	unsavedUserChangesAtom,
} from "@/lib/state/pages/manage-users";
import { cn } from "@/lib/utils";
import { TUser } from "@/types";
import { useAtom, useSetAtom } from "jotai";
import { useState } from "react";
import CreateUser from "./create-user";

export default function UserSelector(props: { users: TUser[] }) {
	const [filter, setFilter] = useState<string>("");
	const [editingUser, setEditingUser] = useAtom(editingUserAtom);
	const [unsavedUserChanges, _] = useAtom(unsavedUserChangesAtom);
	const setShouldAnimateUnsavedUserChanges = useSetAtom(shouldAniamteUnsavedUserChangesAtom);
	const { role, user } = useAuth();

	function onUserClick(user: TUser) {
		if (role?.orderLevel! <= user.role?.orderLevel!) return;

		if (unsavedUserChanges) {
			setShouldAnimateUnsavedUserChanges(true);
			setTimeout(() => {
				setShouldAnimateUnsavedUserChanges(false);
			}, 1500);
			return;
		}

		setEditingUser(user);
	}

	return (
		<div className="col-span-1 w-full h-full border-r">
			{/* Header */}
			<div className="w-full h-20 flex flex-col justify-center border-b px-5">
				<h1 className="text-lg font-semibold">Manage Users</h1>
				<p className="text-sm text-muted-foreground">Modify & Create Users</p>
			</div>

			{/* Content */}
			<div className="px-5 pt-5">
				<div className="flex items-center gap-2">
					<SearchInput placeholder="Search Users" value={filter} onChange={setFilter} />
					<CreateUser />
				</div>

				{/* User List */}
				<div className="grid gap-2 mt-2">
					{props.users
						.filter((u) => u.id !== user.id)
						.filter(
							(u) =>
								u.userName.toLowerCase().includes(filter.toLowerCase()) ||
								u.role?.friendlyName.toLowerCase().includes(filter.toLowerCase())
						)
						.map((user) => (
							<div
								onClick={() => onUserClick(user)}
								key={user.id}
								className={cn(
									"border rounded-lg p-2 pr-3 flex items-center gap-2.5 select-none cursor-pointer hover:bg-muted",
									editingUser?.id === user.id && "bg-muted",
									role?.orderLevel! <= user.role?.orderLevel! &&
										"grayscale hover:bg-transparent cursor-not-allowed"
								)}
							>
								<Avatar className="w-5 h-5">
									<AvatarImage
										src={`https://avatar.vercel.sh/${
											user.userName
										}.svg?text=${user.userName.slice(0, 2).toUpperCase()}`}
									/>
								</Avatar>
								<p className="flex-1">{user.userName}</p>
								<span className="text-muted-foreground text-sm">
									{user.role?.friendlyName}
								</span>
							</div>
						))}
				</div>
			</div>
		</div>
	);
}
