import { authLoadingAtom, authTokenAtom } from "@/lib/state";
import { userAtom } from "@/lib/state/user";
import { useAtom } from "jotai";

export function useAuth() {
	const [authToken, setAuthToken] = useAtom(authTokenAtom);
	const [user, setUser] = useAtom(userAtom);
	const [isAuthLoading, setAuthLoading] = useAtom(authLoadingAtom);

	const isLoggedIn = !isAuthLoading && authToken;

	return {
		isLoggedIn,
		isLoading: isAuthLoading,
		user,
	};
}
