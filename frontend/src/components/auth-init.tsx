import { Fetch } from "@/lib";
import { ApiEndponts } from "@/lib/config";
import { authLoadingAtom, authTokenAtom } from "@/lib/state";
import { userAtom } from "@/lib/state/user";
import { TAuthResponse } from "@/types";
import { useSetAtom } from "jotai";
import { useCallback, useEffect } from "react";

export default function AuthInit() {
	const setAuthToken = useSetAtom(authTokenAtom);
	const setUser = useSetAtom(userAtom);
	const setAuthLoading = useSetAtom(authLoadingAtom);

	const initalizeAuth = useCallback(async () => {
		const refreshTokenResponse = await Fetch.Get<TAuthResponse>(
			ApiEndponts.Auth.Refresh
		);

		setAuthLoading(false);

		// Set auth token and user data.
		if (refreshTokenResponse.ok && refreshTokenResponse.data) {
			setAuthToken(refreshTokenResponse.data.authToken);
			setUser(refreshTokenResponse.data.data);
		} else {
			console.log("error occured while setting up login.");
		}
	}, [setAuthToken, setUser, setAuthLoading]);

	useEffect(() => {
		initalizeAuth();
	}, []);

	return null;
}
