import { cn } from "@/lib/utils";
import React from "react";
import { Link } from "wouter";
import { Slot } from "@radix-ui/react-slot";

export default function WithLink(
	props: React.PropsWithChildren<{
		withLink?: boolean;
		href?: string;
		className?: string;
	}>
) {
	if (!props.withLink || !props.href) {
		return props.children;
	}

	return (
		<Link
			href={props.href}
			className={cn("cursor-pointer", props.className)}
		>
			{props.children}
		</Link>
	);
}
