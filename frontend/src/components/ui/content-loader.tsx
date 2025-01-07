import { cn } from "@/lib/utils";
import { Loader } from "lucide-react";
import React from "react";
interface Props {}
type MakeRequired<Type> = { [key in keyof Type]-?: NonNullable<Type[key]> };
function isLoaded<T extends {}>(data: T): data is MakeRequired<T> {
	return Object.values(data).every((v) => v !== undefined && v !== null);
}

export default function ContentLoader<T extends Props>(props: {
	data: T;
	isLoading: Array<boolean>;
	errors: Array<Error | undefined>;
	loader?: any;
	loaderClassName?: string;
	children: (data: MakeRequired<T>) => React.ReactElement;
}) {
	if (
		isLoaded(props.data) &&
		props.errors?.filter(Boolean).length === 0 &&
		props.isLoading.filter((v) => v === true).length === 0
	)
		return props.children(props.data);

	if (props.errors?.filter(Boolean).length !== 0) return "Error Occured";

	return props.loader || <Loader className={cn("animate-spin", props.loaderClassName)} />;
}
