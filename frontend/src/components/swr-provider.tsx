import { authTokenAtom } from "@/lib/state";
import { useAtomValue } from "jotai";
import React from "react";
import { SWRConfig } from "swr";

export default function SWRProvider(props: React.PropsWithChildren) {
	const authToken = useAtomValue(authTokenAtom);

	return (
		<SWRConfig
			value={{
				errorRetryInterval: 250,
				errorRetryCount: 3,
				fetcher: (resource, init) =>
					fetch(`https://localhost:7252${resource}`, {
						...init,
						headers: { Authorization: `Bearer ${authToken}` },
					}).then((res) => res.json()),
			}}
		>
			{props.children}
		</SWRConfig>
	);
}
