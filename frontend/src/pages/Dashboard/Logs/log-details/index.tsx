import { Dialog, DialogClose, DialogContent } from "@/components/ui/dialog";
import { useSearchParam, useSearchParams } from "@/hooks";
import { ApiEndponts } from "@/lib/config";
import { cn, toQuery } from "@/lib/utils";
import { TLog } from "@/types/api/logs";
import dayjs from "dayjs";
import useSWR from "swr";
import { useLocation } from "wouter";
import LevelBadge from "../log-table/level-badge";
import LogKvpTable from "./kvp-table";
import { Bookmark, IdCard, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useEffect, useState } from "react";

export default function LogDetails() {
	const logId = useSearchParam("logId");
	const [isOpen, setIsOpen] = useState<boolean>(false);
	const searchParams = useSearchParams();
	const [_, setLocation] = useLocation();

	const { data: log } = useSWR<TLog>(logId && ApiEndponts.Logs.GetLogById(logId));

	function handleClose() {
		const queryString = toQuery({ ...searchParams, logId: "" });
		setLocation(queryString ? `/logs?${queryString}` : "/logs");
	}

	useEffect(() => {
		setIsOpen(Boolean(logId));
	}, [logId]);

	return (
		<Dialog open={isOpen} onOpenChange={handleClose}>
			<DialogContent className="p-0 overflow-hidden gap-0 space-y-0 focus-visible:border-0 focus-visible:outline-none outline-none">
				{log && (
					<>
						{" "}
						<div className="w-full min-h-5 max-h-5">
							<img
								className="w-full h-full object-cover object-center"
								src={`https://avatar.vercel.sh/${new Date(
									log.createdAt
								).toISOString()}.svg`}
							/>
						</div>
						<div className="p-5">
							<div className="flex items-center gap-4">
								<div className="flex-1 flex items-center gap-4">
									<h2 className="text-xl font-bold mb-0.5">
										{dayjs(log.createdAt).format("MMM DD HH:mm:ss")}
									</h2>
									<LevelBadge level={log.level} />
								</div>
								<DialogClose asChild>
									<Button
										size={"icon"}
										variant={"ghost"}
										className="w-fit h-fit p-1"
									>
										<X />
									</Button>
								</DialogClose>
							</div>
							<div className="my-5 mb-6">
								<h4 className="font-semibold text-lg">Message</h4>
								<p
									className={cn(
										"text-muted-foreground mt-0.5",
										log.level === "error" && "text-red-300"
									)}
								>
									{log.message}
								</p>
							</div>

							<LogKvpTable metadata={log.metadata} />
						</div>
					</>
				)}
			</DialogContent>
		</Dialog>
	);
}
