import { Sidebar, SidebarProvider } from "@/components/ui/sidebar";
import React from "react";
import AppSidebar from "./side-bar";
import { cn } from "@/lib/utils";

export default function DashboardLayout(props: React.PropsWithChildren<{ className?: string }>) {
	return (
		<SidebarProvider>
			<AppSidebar />
			<main className={cn("w-full min-h-dvh max-h-dvh", props.className)}>
				{props.children}
			</main>
		</SidebarProvider>
	);
}
