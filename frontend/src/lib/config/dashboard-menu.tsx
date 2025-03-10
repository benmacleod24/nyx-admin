import { Home, Scroll, Settings, Users } from "lucide-react";
import { Permissions } from "./permissions";

export type TMenuItem = {
	icon?: any;
	title: string;
	href?: string;
	permissions?: string[];
	roles?: string[];
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
		href: "/citizens",
		permissions: [Permissions.ViewPlayers],
	},
	{
		title: "Logs",
		href: "/logs",
		icon: Scroll,
		permissions: [Permissions.ViewLogs],
	},
	{
		title: "Settings",
		icon: Settings,
		children: [
			{
				href: "/settings",
				title: "General",
				permissions: [Permissions.ViewSystemSettings],
			},
			{
				href: "/settings/users",
				title: "Users",
				permissions: [Permissions.ViewUsers],
			},
			{
				href: "/settings/roles",
				title: "Roles",
				permissions: [Permissions.ViewRoles],
			},
		],
	},
];
