import { globalStore } from "@/lib/state";
import { Provider as JotaiProvider } from "jotai";
import React from "react";
import SWRProvider from "./swr-provider";
import AuthInit from "./auth-init";

export default function AppProviders(props: React.PropsWithChildren) {
	return (
		<JotaiProvider store={globalStore}>
			<AuthInit>
				<SWRProvider>{props.children}</SWRProvider>
			</AuthInit>
		</JotaiProvider>
	);
}
