import { authLoadingAtom, authTokenAtom } from "@/lib/state";
import {
	permissionKeysAtom,
	permissionsLoadedAtom,
} from "@/lib/state/permissions";
import { userAtom } from "@/lib/state/user";
import { TUser } from "@/types";
import { useAtom, useAtomValue } from "jotai";
import { useCallback } from "react";

export function useAuth() {
	const [authToken, setAuthToken] = useAtom(authTokenAtom);
	const [user, setUser] = useAtom(userAtom);
	const [isAuthLoading, setAuthLoading] = useAtom(authLoadingAtom);
	const permissionKeys = useAtomValue(permissionKeysAtom);
	const hasPermissionsLoaded = useAtomValue(permissionsLoadedAtom);

	const isLoggedIn = !isAuthLoading && authToken;

	const hasPermission = useCallback(
		(permission: string | string[]) => {
			if (!permissionKeys) return false;

			if (typeof permission === "string") {
				return permissionKeys.includes(permission);
			}

			const permissionSet = new Set(permissionKeys);
			return permission.some((p) => permissionSet.has(p));
		},
		[permissionKeys]
	);

	return {
		isLoggedIn,
		isLoading: isAuthLoading,
		user: user as Omit<TUser, "role">,
		role: user?.role,
		roleKey: user?.role?.key,
		permissions: permissionKeys,
		hasPermission,
		isPermissionsReady: hasPermissionsLoaded,
	};
}
