import {
	shouldAniamteUnsaveChangesAtom,
	unsavedRoleChangesAtom,
} from "@/lib/state/pages/manage-roles";
import { useAtom, useAtomValue, useSetAtom } from "jotai";
import React from "react";
import { Router, Switch, useRouter } from "wouter";
import { useBrowserLocation } from "wouter/use-browser-location";

function useCustomLocation(): ReturnType<typeof useBrowserLocation> {
	const [location, setLocation] = useBrowserLocation();

	const unsavedRoleChanges = useAtomValue(unsavedRoleChangesAtom);
	const setAnimateUnsavedRoleChanges = useSetAtom(shouldAniamteUnsaveChangesAtom);

	const handleChangeLocation = (newLocation: string | URL) => {
		if (unsavedRoleChanges) {
			setAnimateUnsavedRoleChanges(true);
			setTimeout(() => {
				setAnimateUnsavedRoleChanges(false);
			}, 1500);
			return;
		}

		setLocation(newLocation);
	};

	return [location, handleChangeLocation];
}

export default function WouterProvider(props: React.PropsWithChildren) {
	return (
		<Router hook={useCustomLocation}>
			<Switch>{props.children}</Switch>
		</Router>
	);
}
