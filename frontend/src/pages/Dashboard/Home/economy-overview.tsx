import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { ApiEndponts } from "@/lib/config";
import { TEconomyOverviewReport } from "@/types/api/reports/economy-overview";
import { Loader } from "lucide-react";
import { Bar, BarChart, CartesianGrid, ResponsiveContainer, XAxis, YAxis } from "recharts";
import useSWR from "swr";
import {
	ChartContainer,
	ChartLegend,
	ChartLegendContent,
	ChartTooltip,
	ChartTooltipContent,
} from "@/components/ui/chart";
import dayjs from "dayjs";
import utc from "dayjs/plugin/utc";
import timezone from "dayjs/plugin/timezone";
import { useState } from "react";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";

dayjs.extend(utc);
dayjs.extend(timezone);

export default function EconomyOverview() {
	const [daysAgo, setDaysAgo] = useState("7");

	const { data, isLoading } = useSWR<TEconomyOverviewReport>(
		ApiEndponts.Reports.EconomyOverview + `?daysAgo=${daysAgo}`
	);

	function formatDate(date: string) {
		if (parseInt(daysAgo) <= 1) {
			return dayjs.utc(date).format("h A");
		}

		if (parseInt(daysAgo) <= 7) {
			return dayjs.utc(date).format("ddd");
		}

		if (parseInt(daysAgo) <= 30) {
			return dayjs.utc(date).format("ddd D");
		}

		return dayjs.utc(date).format("MMM");
	}

	return (
		<Card>
			<CardHeader className="flex items-center flex-row justify-between">
				<div className="space-y-1.5">
					<CardTitle>Economy Overview</CardTitle>
					<CardDescription>
						All the money within the economy compared to the outstanding debt with the
						economy.
					</CardDescription>
				</div>
				<Select value={daysAgo} onValueChange={(e) => setDaysAgo(e)}>
					<SelectTrigger className="w-[180px]">
						<SelectValue placeholder="Time Range" />
					</SelectTrigger>
					<SelectContent>
						<SelectItem value="1">Past 24 Hours</SelectItem>
						<SelectItem value="7">Past Week</SelectItem>
						<SelectItem value="30">Past Month</SelectItem>
						<SelectItem value="180">Past 6 Months</SelectItem>
					</SelectContent>
				</Select>
			</CardHeader>
			<CardContent>
				{isLoading && (
					<div className="mx-auto">
						<Loader className="text-brand animate-spin" />
					</div>
				)}

				{data && (
					<ChartContainer
						config={{
							totalDollars: { label: "Total", color: "hsl(var(--chart-1))" },
							totalOutstandingDollars: {
								label: "Outstanding",
								color: "hsl(var(--chart-2))",
							},
						}}
					>
						<BarChart data={data} accessibilityLayer>
							<CartesianGrid vertical={false} />
							<XAxis
								dataKey="date"
								tickLine={false}
								tickMargin={10}
								axisLine={false}
								tickFormatter={(value) => formatDate(value)}
							/>
							<YAxis
								tickFormatter={(v: number) => v.toLocaleString()}
								interval={"preserveEnd"}
							/>
							<ChartTooltip
								content={
									<ChartTooltipContent
										labelFormatter={(value) => formatDate(value)}
										indicator="dot"
									/>
								}
							/>
							<Bar
								dataKey="totalDollars"
								fill="var(--color-totalDollars)"
								radius={4}
							/>
							<Bar
								dataKey="totalOutstandingDollars"
								fill="var(--color-totalOutstandingDollars)"
								radius={4}
							/>
							<ChartLegend content={<ChartLegendContent />} />
						</BarChart>
					</ChartContainer>
				)}
			</CardContent>
		</Card>
	);
}
