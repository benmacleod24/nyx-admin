import { globalStore } from "@/lib/state";
import { Provider as JotaiProvider } from "jotai";
import React from "react";

export default function AppProviders(props: React.PropsWithChildren) {
	return <JotaiProvider store={globalStore}>{props.children}</JotaiProvider>;
}
