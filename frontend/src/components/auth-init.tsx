import { Fetch } from "@/lib";
import { ApiEndponts } from "@/lib/config";
import { authLoadingAtom, authTokenAtom } from "@/lib/state";
import { userAtom } from "@/lib/state/user";
import { TAuthResponse } from "@/types";
import { useAtom, useSetAtom } from "jotai";
import { Loader } from "lucide-react";
import React, { useCallback, useEffect } from "react";

export default function AuthInit(props: React.PropsWithChildren) {
	const setAuthToken = useSetAtom(authTokenAtom);
	const setUser = useSetAtom(userAtom);
	const [authLoading, setAuthLoading] = useAtom(authLoadingAtom);

	const initalizeAuth = useCallback(async () => {
		const refreshTokenResponse = await Fetch.Get<TAuthResponse>(ApiEndponts.Auth.Refresh);

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

	if (authLoading) {
		return (
			<div className="flex flex-col items-center justify-center w-screen h-dvh gap-1.5">
				<Loader className="text-brand animate-spin" />
				<p className="text-sm text-muted-foreground">Checking Authentication</p>
			</div>
		);
	}

	return props.children;
}
