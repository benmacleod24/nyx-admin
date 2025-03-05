import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import {
	DropdownMenu,
	DropdownMenuContent,
	DropdownMenuTrigger,
	DropdownMenuGroup,
	DropdownMenuItem,
	DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import {
	SidebarFooter as SidebarFooterUI,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
	useSidebar,
} from "@/components/ui/sidebar";
import WithLink from "@/components/ui/with-link";
import { useAuth } from "@/hooks";
import { Permissions } from "@/lib/config";
import { UserDropdownOptions } from "@/lib/config/user-dropdown-options";
import { ChevronsUpDown, Settings } from "lucide-react";
import React from "react";
import { Link } from "wouter";

export default function SidebarFooter() {
	const { isMobile } = useSidebar();
	const { user, role, hasPermission } = useAuth();

	if (!user) return;

	return (
		<SidebarFooterUI>
			<SidebarMenu>
				<SidebarMenuItem>
					<DropdownMenu>
						<DropdownMenuTrigger asChild>
							<SidebarMenuButton size="lg">
								<Avatar className="h-8 w-8 rounded-lg">
									<AvatarImage
										src={
											user &&
											`https://avatar.vercel.sh/${
												user.userName
											}.svg?text=${user.userName.slice(0, 2).toUpperCase()}`
										}
									/>
									<AvatarFallback>
										{user && user.userName.slice(0, 2).toUpperCase()}
									</AvatarFallback>
								</Avatar>
								<div className="grid flex-1 text-left ml-1 text-sm leading-tight">
									<span className="truncate font-semibold">{user.userName}</span>
									<span className="truncate text-xs">{role?.friendlyName}</span>
								</div>
								<ChevronsUpDown className="ml-auto size-4" />
							</SidebarMenuButton>
						</DropdownMenuTrigger>
						<DropdownMenuContent
							className="w-[--radix-dropdown-menu-trigger-width] min-w-56 rounded-lg"
							side={isMobile ? "bottom" : "right"}
							align="end"
							sideOffset={4}
						>
							{UserDropdownOptions.map((group, idx) => (
								<React.Fragment key={idx}>
									{idx ? <DropdownMenuSeparator /> : ""}
									<DropdownMenuGroup>
										{group.map((option, index) => (
											<WithLink key={index + idx} href={option.href} withLink>
												<DropdownMenuItem
													onClick={
														option.onClick ? option.onClick : () => {}
													}
												>
													<option.icon />
													{option.title}
												</DropdownMenuItem>
											</WithLink>
										))}
									</DropdownMenuGroup>
								</React.Fragment>
							))}
						</DropdownMenuContent>
					</DropdownMenu>
				</SidebarMenuItem>
			</SidebarMenu>
		</SidebarFooterUI>
	);
}
