import { Home, Scroll, Settings, Users } from "lucide-react";
import { Permissions } from "./permissions";

export type TMenuItem = {
	icon?: any;
	title: string;
	href?: string;
	permissions?: string[];
	children?: { title: string; href: string; permissions?: string[] }[];
	onClick?: () => void;
};

export const MenuOptions: TMenuItem[] = [
	{
		title: "Overview",
		icon: Home,
		href: "/",
	},
	{
		title: "Players",
		icon: Users,
		href: "/players",
	},
	{
		title: "Logs",
		href: "/logs",
		icon: Scroll,
	},
	{
		title: "Settings",
		icon: Settings,
		children: [
			{
				href: "/settings/users",
				title: "Users",
				permissions: [Permissions.ViewRoles],
			},
			{
				href: "/settings/roles",
				title: "Roles",
				permissions: [Permissions.ViewRoles],
			},
		],
	},
];
