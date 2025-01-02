import React from "react";
import { Switch } from "wouter";

export default function WouterProvider(props: React.PropsWithChildren) {
	return <Switch>{props.children}</Switch>;
}
