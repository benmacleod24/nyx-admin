import AddLogFilter from "./add-filter";
import { useAtom } from "jotai";
import { logSearchFilterAtom } from "@/lib/state/pages/logs";
import { CalendarSearch, Settings2, XCircle } from "lucide-react";
import { toFlatCase } from "@/lib/utils";
import { useAutoAnimate } from "@formkit/auto-animate/react";
import { Button } from "@/components/ui/button";
import TableSettings from "./add-columns";
import Timerange from "./timerange";

export const OperatorToPlaintext: Record<string, string> = {
	equals: "equals (=)",
	contains: "contains",
	notEquals: "does not equal (!=)",
};

export default function LogsSearchBar() {
	const [animateRef] = useAutoAnimate();
	const [filters, setFilters] = useAtom(logSearchFilterAtom);

	function removeFilter(filterIndex: number) {
		const newFilters = filters.filter((_, i) => i !== filterIndex);
		setFilters(newFilters);
	}

	return (
		<div className="flex items-center gap-2 my-4">
			<div className="flex gap-2 flex-wrap transition-all">
				{filters.map((filter, index) => (
					<div
						key={index}
						className="rounded-full border flex items-center px-3 gap-1 border-brand bg-brand/20 text-sm text-brand"
					>
						<span className="font-semibold">{toFlatCase(filter.key)}</span>
						<span className="italic">{OperatorToPlaintext[filter.method]}</span>
						<span className="text-mono">"{filter.value}"</span>
						<XCircle
							size={16}
							onClick={() => removeFilter(index)}
							className="ml-1 cursor-pointer hover:text-white transition-colors"
						/>
					</div>
				))}
				<AddLogFilter />
			</div>
			<Timerange />
			<TableSettings />
		</div>
	);
}
