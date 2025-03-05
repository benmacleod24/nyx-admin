import { Collapsible, CollapsibleContent, CollapsibleTrigger } from "@/components/ui/collapsible";
import {
	SidebarContent,
	SidebarGroup,
	SidebarMenu,
	SidebarMenuButton,
	SidebarMenuItem,
	SidebarMenuSub,
	SidebarMenuSubButton,
	SidebarMenuSubItem,
} from "@/components/ui/sidebar";
import WithLink from "@/components/ui/with-link";
import { useAuth } from "@/hooks";
import { MenuOptions, TMenuItem } from "@/lib/config";
import { ChevronRight } from "lucide-react";
import { useCallback, useMemo } from "react";
import { Link, useLocation } from "wouter";

export default function SidebarMenuOptions() {
	return (
		<SidebarGroup>
			<SidebarContent>
				<SidebarMenu>
					{MenuOptions.map((option, index) => {
						return option.children && option.children.length >= 1 ? (
							<SidebarMenuOptionWithChildren option={option} key={index} />
						) : (
							<SidebarMenuOption option={option} key={index} />
						);
					})}
				</SidebarMenu>
			</SidebarContent>
		</SidebarGroup>
	);
}

export function SidebarMenuOptionWithChildren(props: { option: TMenuItem }) {
	const { hasPermission, permissions } = useAuth();
	const [path] = useLocation();

	// Determine if the user has access to any of the child elements. Keep in memo because of expensive loop.
	// Used to determine if we even need to display any children.
	const hasAnyChildAccess = useMemo(() => {
		if (!props.option.children) return false;

		for (const child of props.option.children) {
			if (child.permissions && hasPermission(child.permissions)) {
				return true;
			}

			if (!child.permissions) {
				return true;
			}
		}
	}, [props.option.children, permissions]);

	// Check if any child element is active in the url. Keep in memo will update as path does.
	// Used to determine if collapsible should be open by default.
	const isChildActive = useMemo(() => {
		if (!props.option.children) return false;

		return props.option.children.some((option) => {
			return option.href === path;
		});
	}, [path]);

	if (!hasAnyChildAccess) return;

	if (!props.option.children || props.option.children.length <= 0 || !hasAnyChildAccess)
		return <SidebarMenuOption option={props.option} />;

	if (props.option.permissions && !hasPermission(props.option.permissions)) return;

	return (
		<Collapsible defaultOpen={isChildActive} className="group/collapsible">
			<SidebarMenuItem>
				<CollapsibleTrigger asChild>
					<SidebarMenuButton>
						{props.option.icon && <props.option.icon />}
						<span>{props.option.title}</span>
						<ChevronRight className="ml-auto transition-transform duration-200 group-data-[state=open]/collapsible:rotate-90" />
					</SidebarMenuButton>
				</CollapsibleTrigger>

				<CollapsibleContent>
					<SidebarMenuSub>
						{props.option.children?.map((option, index) => {
							if (option.permissions && !hasPermission(option.permissions)) return;

							return (
								<SidebarMenuSubItem key={index}>
									<WithLink href={option.href} withLink={Boolean(option.href)}>
										<SidebarMenuSubButton>{option.title}</SidebarMenuSubButton>
									</WithLink>
								</SidebarMenuSubItem>
							);
						})}
					</SidebarMenuSub>
				</CollapsibleContent>
			</SidebarMenuItem>
		</Collapsible>
	);
}

export function SidebarMenuOption(props: { option: Omit<TMenuItem, "children"> }) {
	const { hasPermission } = useAuth();

	if (props.option.permissions && !hasPermission(props.option.permissions)) return;

	return (
		<SidebarMenuItem>
			<WithLink withLink={Boolean(props.option.href)} href={props.option.href}>
				<SidebarMenuButton>
					{props.option.icon && <props.option.icon />} {props.option.title}
				</SidebarMenuButton>
			</WithLink>
		</SidebarMenuItem>
	);
}
