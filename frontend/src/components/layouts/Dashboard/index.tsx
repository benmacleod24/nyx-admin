import { Sidebar, SidebarProvider } from "@/components/ui/sidebar";
import React from "react";
import AppSidebar from "./side-bar";

export default function DashboardLayout(props: React.PropsWithChildren) {
	return (
		<SidebarProvider>
			<AppSidebar />
			<main>{props.children}</main>
		</SidebarProvider>
	);
}
