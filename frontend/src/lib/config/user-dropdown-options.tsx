import { LogOut, Rocket, Settings } from "lucide-react";
import { Fetch } from "../fetch-client";
import { ApiEndponts } from "./api-endpoints";
import { authTokenAtom, globalStore } from "../state";
import { navigate } from "wouter/use-browser-location";

// 2D Array for groups of options
export const UserDropdownOptions: Array<
	Array<{ title: string; icon: any; href?: string; onClick?: () => void }>
> = [
	[
		{
			title: "Settings",
			icon: Settings,
		},
		{
			title: "User Debug",
			icon: Rocket,
			href: "/user-debug",
		},
	],
	[
		{
			title: "Logout",
			icon: LogOut,
			onClick: async () => {
				const resp = await Fetch.Delete(ApiEndponts.Auth.Logout);

				if (resp.ok) {
					globalStore.set(authTokenAtom, undefined);
					navigate("/login");
				}
			},
		},
	],
];
