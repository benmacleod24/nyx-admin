export function toQuery(params: Record<string, string>) {
	const searchParams = new URLSearchParams(params);
	return searchParams.toString();
}
