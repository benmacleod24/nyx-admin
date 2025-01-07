import { cn } from "@/lib/utils";
import { Search } from "lucide-react";

export default function SearchInput(props: {
	value: string;
	placeholder?: string;
	onChange: (v: string) => void;
	className?: string;
}) {
	return (
		<div
			className={cn(
				"flex items-center w-full border rounded-lg min-h-10 px-2",
				props.className
			)}
		>
			<Search className="mr-2 text-muted-foreground" />
			<input
				value={props.value}
				onChange={(e) => props.onChange(e.target.value)}
				className="w-full h-10 bg-transparent border-none outline-none"
				placeholder={props.placeholder}
			/>
		</div>
	);
}
