import { Badge } from "@/components/ui/badge";
import { cn } from "@/lib/utils";

export default function LevelBadge({ level, className }: { level: string; className?: string }) {
	switch (level) {
		case "info":
			return (
				<div className="border border-blue-500 h-fit w-fit capitalize px-2 rounded-md bg-blue-400/20">
					<span className="text-blue-500 leading-none mt-0 py-0 text-sm">{level}</span>
				</div>
			);
		case "error":
			return (
				<div className="border border-red-500 h-fit w-fit capitalize px-2 rounded-md bg-red-400/20">
					<span className="text-red-500 leading-none mt-0 py-0 text-sm">{level}</span>
				</div>
			);
		case "warn":
			return (
				<div className="border border-amber-400 h-fit w-fit capitalize px-2 rounded-md bg-amber-400/20">
					<span className="text-amber-400 leading-none mt-0 py-0 text-sm">{level}</span>
				</div>
			);

		default:
			return (
				<div className="border h-fit w-fit capitalize px-2 rounded-md bg-muted/30">
					<span className="text-muted-foreground leading-none mt-0 py-0 text-sm">
						{level}
					</span>
				</div>
			);
	}
}
