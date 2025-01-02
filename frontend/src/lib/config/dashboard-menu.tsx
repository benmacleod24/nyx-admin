import { Home, Scroll, Users } from "lucide-react";

export type TMenuItem = {
	icon?: any;
	title: string;
	href?: string;
	permissions?: string[];
	onClick?: () => void;
};

export type TMenuGroup = {
	title: string;
	children: TMenuItem[];
};

export const MenuOptions: TMenuGroup[] = [
	{
		title: "Admin Stuff",
		children: [
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
		],
	},
];
