import { useAuth } from "@/hooks";
import { toQuery } from "@/lib/utils";
import React from "react";
import { Redirect, Route } from "wouter";

export type PrivateRouteProps = React.ComponentProps<typeof Route>;

export default function PrivateRoute(props: PrivateRouteProps) {
	const { isLoading, isLoggedIn } = useAuth();

	// Redirect non-logged in users to sign in.
	if (!isLoading && !isLoggedIn) {
		let params: Record<string, string> = {};
		let path = "/login";

		if (props.path) {
			params["redirect"] = props.path.toString();
		}

		if (Object.entries(params).length > 0) {
			path = path + `?${toQuery(params)}`;
		}

		return <Redirect to={path} />;
	}

	return <Route {...props} />;
}
