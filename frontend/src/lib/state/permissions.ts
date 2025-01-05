import { TPermission } from "@/types/api/permissions";
import { atom } from "jotai";
import { globalStore } from ".";
import { userAtom } from "./user";
import { Fetch } from "../fetch-client";
import { ApiEndponts } from "../config";

export const permissionsAtom = atom<TPermission[]>();

export const permissionKeysAtom = atom<string[]>();

export const permissionsLoadedAtom = atom<boolean>(false);

// Observer to list for permissionAtom changes and extract the keys.
globalStore.sub(permissionsAtom, () => {
	const newPermissions = globalStore.get(permissionsAtom);
	if (!newPermissions) return;

	let permissionKeys: string[] = [];
	newPermissions.forEach((permission) => permissionKeys.push(permission.key));

	globalStore.set(permissionsLoadedAtom, true);
	globalStore.set(permissionKeysAtom, permissionKeys);
});

// Watch for changes to user atom, to refetch permissions.
globalStore.sub(userAtom, async () => {
	const permissions = await Fetch.Get<TPermission[]>(ApiEndponts.User.GetPermissions, {
		includeCredentials: true,
	});

	if (permissions.ok && permissions.data) {
		globalStore.set(permissionsAtom, permissions.data);
	}
});
