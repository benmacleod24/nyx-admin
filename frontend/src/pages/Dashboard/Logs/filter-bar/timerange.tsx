import { Button } from "@/components/ui/button";
import { RangeCalendar } from "@/components/ui/calendar-rac";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import { Separator } from "@/components/ui/separator";
import { logTimerangeFilterAtom } from "@/lib/state/pages/logs";
import { getLocalTimeZone, today, now as _now } from "@internationalized/date";
import dayjs from "dayjs";
import { useAtom } from "jotai";
import { CalendarSearch } from "lucide-react";
import { useEffect } from "react";

const _today = today(getLocalTimeZone());

export default function Timerange() {
	const [dateRange, setDateRange] = useAtom(logTimerangeFilterAtom);

	useEffect(() => {
		if (dateRange !== null) return;

		setDateRange({
			start: _today.subtract({ days: 2 }),
			end: _today,
		});
	}, [dateRange]);

	return (
		<Popover>
			<PopoverTrigger asChild>
				<Button
					className="rounded-full data-[state=open]:bg-muted"
					size={"sm"}
					variant={"outline"}
				>
					<CalendarSearch />
					{dateRange
						? `${dayjs(dateRange.start.toString()).format("MMM, DD")} - ${dayjs(
								dateRange.end.toString()
						  ).format("MMM, DD")}`
						: "Date Range"}
				</Button>
			</PopoverTrigger>
			<PopoverContent className="p-0 w-fit" align="start">
				<div className="flex flex-col p-2">
					<RangeCalendar
						value={dateRange}
						onChange={setDateRange}
						isDateUnavailable={(v) => v > _today}
						className={""}
					/>
					<Separator className="my-3" />
					<div className="grid grid-cols-2 gap-2">
						<Button
							size={"sm"}
							variant={"outline"}
							onClick={() =>
								setDateRange({ start: _today.subtract({ days: 1 }), end: _today })
							}
						>
							Past 24 Hours
						</Button>
						<Button
							size={"sm"}
							variant={"outline"}
							onClick={() =>
								setDateRange({ start: _today.subtract({ days: 3 }), end: _today })
							}
						>
							Past 3 Days
						</Button>
						<Button
							size={"sm"}
							variant={"outline"}
							onClick={() =>
								setDateRange({ start: _today.subtract({ days: 7 }), end: _today })
							}
						>
							Past 7 Days
						</Button>
						<Button
							size={"sm"}
							variant={"outline"}
							onClick={() =>
								setDateRange({ start: _today.subtract({ weeks: 4 }), end: _today })
							}
						>
							Past 4 Weeks
						</Button>
					</div>
				</div>
			</PopoverContent>
		</Popover>
	);
}
