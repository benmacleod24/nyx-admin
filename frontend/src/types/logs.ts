import { z } from "zod";

export type TSearchFilter = {
	key: string;
	value: string;
	method: string;
};

export const SearchFilterSchema = z.object({
	key: z.string(),
	value: z.string(),
	method: z.string(),
});
