import { LogOut, Rocket, Settings } from "lucide-react";

// 2D Array for groups of options
export const UserDropdownOptions = [
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
		},
	],
];
