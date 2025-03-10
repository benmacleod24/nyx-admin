import { Button } from "@/components/ui/button";
import { useSearchParam, useSearchParams } from "@/hooks";
import { toQuery } from "@/lib/utils";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useCallback } from "react";
import { useLocation, useParams } from "wouter";

export default function CitizenRemarksPagination({ totalPages }: { totalPages: number }) {
	const { id } = useParams<{ id: string }>();
	const [_, setLocation] = useLocation();
	const page = useSearchParam("page");
	const searchParams = useSearchParams();
	const _page = page ? parseInt(page) : 1;

	const incrementPage = useCallback(() => {
		setLocation(
			`/citizens/${id}/remarks?${toQuery({ ...searchParams, page: String(_page + 1) })}`
		);
	}, [page, searchParams]);

	const decrementPage = useCallback(() => {
		setLocation(
			`/citizens/${id}/remarks?${toQuery({ ...searchParams, page: String(_page - 1) })}`
		);
	}, [page, searchParams]);

	if (totalPages === 1) return;

	return (
		<div className="flex items-center gap-3 mt-5">
			<Button
				onClick={decrementPage}
				disabled={_page <= 1}
				size={"icon"}
				className="h-8 w-8"
				variant={"outline"}
			>
				<ChevronLeft />
			</Button>
			<span className="select-none">
				{_page} of {totalPages}
			</span>
			<Button
				onClick={incrementPage}
				disabled={_page >= totalPages}
				size={"icon"}
				className="h-8 w-8"
				variant={"outline"}
			>
				<ChevronRight />
			</Button>
		</div>
	);
}
