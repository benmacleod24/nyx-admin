import { Button } from "@/components/ui/button";
import {
	Command,
	CommandEmpty,
	CommandGroup,
	CommandInput,
	CommandItem,
	CommandList,
} from "@/components/ui/command";
import {
	Form,
	FormControl,
	FormDescription,
	FormField,
	FormItem,
	FormLabel,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import {
	Select,
	SelectTrigger,
	SelectValue,
	SelectContent,
	SelectItem,
} from "@/components/ui/select";
import { zodResolver } from "@hookform/resolvers/zod";
import { Check, ChevronDown, CirclePlus, MoveRight } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { cn, toQuery } from "@/lib/utils";
import { useSearchParams } from "@/hooks";
import { TSearchFilter } from "@/types/logs";
import { searchFilterArraySchema } from "../../Logs";
import { useLocation } from "wouter";
import { filterOperators } from "../configs/filter-operators";
import { playersSearchFilter } from "../configs/search-filters";
import useSWR from "swr";
import { ApiEndponts } from "@/lib/config";
import { TableColumn } from "@/types/api/table-columns";

type FormSchema = z.infer<typeof formSchema>;
const formSchema = z.object({
	key: z.string(),
	value: z.string(),
	operator: z.string(),
});

export default function AddPlayersFilter({ tableColumns }: { tableColumns?: TableColumn[] }) {
	const [popoverOpen, setPopoverOpen] = useState<boolean>(false);
	const [operatorSelectOpen, setOperatorSelectOpen] = useState<boolean>(false);
	const [fieldSelectOpen, setFieldSelectOpen] = useState<boolean>(false);
	const [fieldSearch, setFieldSearch] = useState<string>("");

	const searchParams = useSearchParams<{ filters: string }>();
	const [_, setLocation] = useLocation();

	const form = useForm<FormSchema>({
		resolver: zodResolver(formSchema),
		defaultValues: {
			operator: "==",
			key: "citizenId",
		},
	});

	function onSubmit(values: FormSchema) {
		const safeSearchFilters = searchFilterArraySchema.safeParse(
			JSON.parse(searchParams.filters || "[]")
		);

		let filters: TSearchFilter[] = [];

		if (safeSearchFilters.success) filters = [...safeSearchFilters.data];
		filters = [...filters, { key: values.key, method: values.operator, value: values.value }];

		setLocation(`/players?${toQuery({ ...searchParams, filters: JSON.stringify(filters) })}`);
	}

	return (
		<Popover
			open={popoverOpen}
			onOpenChange={(open) => !operatorSelectOpen && !fieldSelectOpen && setPopoverOpen(open)}
		>
			<PopoverTrigger asChild>
				<Button
					variant={"outline"}
					size={"sm"}
					className="rounded-lg data-[state=open]:bg-muted"
				>
					<CirclePlus /> Add Filter
				</Button>
			</PopoverTrigger>
			<PopoverContent align="start" className="min-w-[400px]">
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)}>
						<div className="space-y-3">
							<FormField
								control={form.control}
								name="key"
								render={({ field }) => (
									<FormItem className="flex flex-col w-full">
										<FormLabel>Field</FormLabel>
										<Popover
											open={fieldSelectOpen}
											onOpenChange={setFieldSelectOpen}
										>
											<PopoverTrigger asChild>
												<Button
													size={"sm"}
													variant={"outline"}
													className="font-normal capitalize justify-between"
												>
													{playersSearchFilter.find(
														(f) => f.value === field.value
													)?.title || "N/A"}
													<ChevronDown className="opacity-50" />
												</Button>
											</PopoverTrigger>
											<PopoverContent className="p-0 w-[--radix-popover-trigger-width]">
												<Command>
													<CommandInput
														value={fieldSearch}
														onValueChange={setFieldSearch}
														placeholder="Search Fields"
													/>
													<CommandList>
														<CommandEmpty />
														<CommandGroup>
															{tableColumns &&
																tableColumns
																	.filter((f) =>
																		f.friendlyName
																			? f.friendlyName
																					.toLowerCase()
																					.includes(
																						fieldSearch.toLowerCase()
																					)
																			: f.valuePath
																					.toLowerCase()
																					.includes(
																						fieldSearch.toLowerCase()
																					)
																	)
																	.map((f) => (
																		<CommandItem
																			key={f.valuePath}
																			value={f.valuePath}
																			onSelect={() => {
																				field.onChange(
																					f.valuePath
																				);
																				setFieldSelectOpen(
																					false
																				);
																			}}
																		>
																			<Check
																				className={cn(
																					f.valuePath ===
																						field.value
																						? "opacity-100"
																						: "opacity-0"
																				)}
																			/>
																			{f.friendlyName ||
																				f.valuePath}
																		</CommandItem>
																	))}
														</CommandGroup>
													</CommandList>
												</Command>
											</PopoverContent>
										</Popover>
										<FormDescription>
											The field you would like to search.
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="operator"
								defaultValue={"contains"}
								render={({ field }) => (
									<FormItem>
										<FormLabel>Operator</FormLabel>
										<Select
											open={operatorSelectOpen}
											onOpenChange={setOperatorSelectOpen}
											onValueChange={field.onChange}
											defaultValue={field.value}
										>
											<FormControl>
												<SelectTrigger className="capitalize">
													<SelectValue placeholder="Select Key" />
												</SelectTrigger>
											</FormControl>
											<SelectContent>
												{filterOperators.map((o) => (
													<SelectItem key={o.value} value={o.value}>
														{o.title}
													</SelectItem>
												))}
											</SelectContent>
										</Select>
										<FormDescription>
											The operator to apply for this filter.
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>
							<FormField
								control={form.control}
								name="value"
								render={({ field }) => (
									<FormItem>
										<FormLabel>Value</FormLabel>
										<FormControl>
											<Input placeholder="value" {...field} />
										</FormControl>
										<FormDescription>
											The value to search for in this filter.
										</FormDescription>
										<FormMessage />
									</FormItem>
								)}
							/>
						</div>
						<Button className="w-full group mt-3" size={"sm"}>
							Add Filter{" "}
							<MoveRight className="group-hover:translate-x-1 transition-transform" />
						</Button>
					</form>
				</Form>
			</PopoverContent>
		</Popover>
	);
}
