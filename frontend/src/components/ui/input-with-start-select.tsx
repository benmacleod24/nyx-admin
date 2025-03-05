import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { ChevronDown } from "lucide-react";
import React, { useId } from "react";

export type InputWithStartSelectProps = {
	inputProps?: React.ComponentProps<typeof Input>;
	selectProps?: React.ComponentProps<"select">;
	children: React.ReactNode;
};

export default function InputWithStartSelect(props: InputWithStartSelectProps) {
	const id = useId();
	return (
		<div className="space-y-2">
			<div className="flex rounded-lg shadow-sm shadow-black/5">
				<div className="relative">
					<select
						className="peer inline-flex h-full appearance-none items-center rounded-none rounded-s-lg border border-input bg-background pe-8 ps-3 text-sm text-muted-foreground transition-shadow hover:bg-accent hover:text-accent-foreground focus:z-10 focus-visible:border-ring focus-visible:text-foreground focus-visible:outline-none focus-visible:ring-[3px] focus-visible:ring-ring/20 disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50"
						{...props.selectProps}
					>
						{props.children}
					</select>
					<span className="pointer-events-none absolute inset-y-0 end-0 z-10 flex h-full w-9 items-center justify-center text-muted-foreground/80 peer-disabled:opacity-50">
						<ChevronDown size={16} strokeWidth={2} aria-hidden="true" role="img" />
					</span>
				</div>
				<Input
					id={id}
					className="-ms-px rounded-s-none shadow-none focus-visible:z-10"
					{...props.inputProps}
				/>
			</div>
		</div>
	);
}
