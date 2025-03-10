// The operators allowed to be used in a filter.
export const filterOperators: { title: string; value: string }[] = [
	{ title: "Equals (==)", value: "==" },
	{ title: "Not Equals (!=)", value: "!=" },
	{ title: "Contains", value: "contains" },
	{ title: "Greater Than (>)", value: ">" },
	{ title: "Greater Than Or Equal (>=)", value: ">=" },
	{ title: "Less Than (<)", value: "<" },
	{ title: "Less Than Or Equal (<=)", value: "<=" },
];
