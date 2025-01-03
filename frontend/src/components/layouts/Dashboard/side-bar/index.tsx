import {
	Sidebar,
	SidebarContent,
	SidebarGroup,
	SidebarGroupContent,
	SidebarGroupLabel,
	SidebarHeader,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
} from "@/components/ui/sidebar";
import { MenuOptions } from "@/lib/config";
import { Home, Users } from "lucide-react";
import { Link } from "wouter";
import SidebarFooter from "./footer";
import SidebarMenuOptions from "./menu";

export default function AppSidebar() {
	return (
		<Sidebar>
			<SidebarHeader>
				<div className="w-full h-20 rounded-lg border overflow-hidden relative">
					<img
						className="w-full h-full object-cover object-center"
						src="https://cdn.discordapp.com/attachments/1134640027691917343/1318173921660370974/2.0-announcement.png?ex=6777c621&is=677674a1&hm=7cc4f8a60460ea8aee3ed510142a9030b496ddc5d6e6178b18c8c47fca670289&"
					/>
					{/* <div className="absolute top-0 left-0 w-full flex items-end p-2 h-full bg-gradient-to-t from-black to-transparent">
						<h1 className="text-lg font-semibold backdrop-blur-[1px]">
							NYX Admin
						</h1>
					</div> */}
				</div>
			</SidebarHeader>
			<SidebarContent>
				<SidebarMenuOptions />
			</SidebarContent>
			<SidebarFooter />
		</Sidebar>
	);
}
