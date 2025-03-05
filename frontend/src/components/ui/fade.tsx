import { cn } from "@/lib/utils";
import { AnimatePresence, motion, Variants } from "motion/react";
import React from "react";

export default function Fade({
	direction = "up",
	offset = 2,
	...props
}: React.PropsWithChildren<{
	open: boolean;
	direction?: "up" | "down" | "left" | "right";
	offset?: number;
	className?: string;
}>) {
	const defaultVariants: Variants = {
		hidden: {
			[direction === "left" || direction === "right" ? "x" : "y"]:
				direction === "right" || direction === "down" ? -offset : offset,
			opacity: 0,
			filter: `blur(2px)`,
		},
		visible: {
			[direction === "left" || direction === "right" ? "x" : "y"]: 0,
			opacity: 1,
			filter: `blur(0px)`,
		},
	};

	return (
		<AnimatePresence mode="wait">
			{props.open && (
				<motion.div
					variants={defaultVariants}
					initial="hidden"
					animate="visible"
					exit="hidden"
					className={cn(props.className)}
					transition={{
						delay: 0.04,
						duration: "0.1",
						ease: "easeOut",
					}}
				>
					{props.children}
				</motion.div>
			)}
		</AnimatePresence>
	);
}
