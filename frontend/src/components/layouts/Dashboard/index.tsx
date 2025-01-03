import { Sidebar, SidebarProvider } from "@/components/ui/sidebar";
import React from "react";
import AppSidebar from "./side-bar";
import { cn } from "@/lib/utils";

export default function DashboardLayout(props: React.PropsWithChildren<{ className?: string }>) {
	return (
		<SidebarProvider>
			<AppSidebar />
			<main className={cn("pl-5 pt-3 w-full", props.className)}>{props.children}</main>
		</SidebarProvider>
	);
}
