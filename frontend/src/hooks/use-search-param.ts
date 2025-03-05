import { useMemo } from "react";
import { useSearch } from "wouter";

export function useSearchParam(paramKey: string) {
	const searchParams = useSearch();
	const params = new URLSearchParams(searchParams);
	return params.get(paramKey);
}

export function useSearchParams<T = Record<string, string>>() {
	const searchParams = useSearch();
	const params = new URLSearchParams(searchParams);

	const paramsObject = useMemo(() => {
		let _params: Record<string, string> = {};
		params.forEach((v, k) => (_params[k] = v));
		return _params;
	}, [searchParams]);

	return paramsObject as T;
}
