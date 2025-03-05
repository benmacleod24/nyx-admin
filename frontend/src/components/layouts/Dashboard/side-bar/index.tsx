import { Sidebar, SidebarContent, SidebarHeader } from "@/components/ui/sidebar";
import SidebarFooter from "./footer";
import SidebarMenuOptions from "./menu";
import BannerImage from "@/styles/images/banner.png";

export default function AppSidebar() {
	return (
		<Sidebar>
			<SidebarHeader>
				<div className="w-full h-20 rounded-lg border overflow-hidden relative">
					<img className="w-full h-full object-cover object-center" src={BannerImage} />
				</div>
			</SidebarHeader>
			<SidebarContent>
				<SidebarMenuOptions />
			</SidebarContent>
			<SidebarFooter />
		</Sidebar>
	);
}
