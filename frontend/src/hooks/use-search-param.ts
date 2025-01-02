import { useSearch } from "wouter";

export function useSearchParam(paramKey: string) {
	const searchParams = useSearch();
	const params = new URLSearchParams(searchParams);
	return params.get(paramKey);
}
