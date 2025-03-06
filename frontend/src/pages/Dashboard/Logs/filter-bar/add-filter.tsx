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
	FormItem,
	FormField,
	FormLabel,
	FormControl,
	FormDescription,
	FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover";
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select";
import { ApiEndponts } from "@/lib/config";
import { logSearchFilterAtom } from "@/lib/state/pages/logs";
import { cn, shuffle, toFlatCase } from "@/lib/utils";
import { zodResolver } from "@hookform/resolvers/zod";
import { useAtom } from "jotai";
import { Check, ChevronDown, PlusCircle } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import useSWR from "swr";
import { z } from "zod";

type FormSchema = z.infer<typeof formSchema>;
const formSchema = z.object({
	key: z.string(),
	value: z.string(),
	operator: z.enum(["contains", "equals", "notEquals"]),
});

export default function AddLogFilter() {
	const [filters, setFilters] = useAtom(logSearchFilterAtom);
	const [keyOpen, setKeyOpen] = useState(false);
	const [operatorOpen, setOperatorOpen] = useState(false);
	const [open, setOpen] = useState(false);
	const [keySearchInput, setKeySearchInput] = useState("");

	const { data: metadataKeys } = useSWR<string[]>(ApiEndponts.Logs.MetadataKeys);

	const form = useForm<FormSchema>({
		resolver: zodResolver(formSchema),
	});

	function onSubmit(values: FormSchema) {
		setFilters([
			...filters,
			{
				key: values.key,
				method: values.operator,
				value: values.value,
			},
		]);
	}

	return (
		<Popover
			open={open}
			onOpenChange={(v) => {
				!keyOpen && !operatorOpen && setOpen(v);
				if (v === false) form.reset({ key: "Level", operator: "equals", value: "" });
			}}
		>
			<PopoverTrigger asChild>
				<Button
					className="rounded-full data-[state=open]:bg-muted"
					size={"sm"}
					variant={"outline"}
				>
					<PlusCircle />
					Add Filter
				</Button>
			</PopoverTrigger>
			<PopoverContent className="min-w-[400px]" align="start">
				<div>
					<h1 className="font-semibold">Add Filter</h1>
					<p className="text-muted-foreground text-sm">Add a search filter for logs.</p>
				</div>
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4 mt-4">
						<FormField
							control={form.control}
							name="key"
							defaultValue={(metadataKeys && metadataKeys[0]) || undefined}
							render={({ field }) => (
								<FormItem className="flex flex-col w-full">
									<FormLabel>Key</FormLabel>
									<Popover open={keyOpen} onOpenChange={setKeyOpen}>
										<PopoverTrigger asChild>
											<Button
												size={"sm"}
												variant={"outline"}
												className="font-normal capitalize justify-between"
											>
												{toFlatCase(field.value)}
												<ChevronDown className="opacity-50" />
											</Button>
										</PopoverTrigger>
										<PopoverContent className="p-0 w-[--radix-popover-trigger-width]">
											<Command>
												<CommandInput
													placeholder="Search Keys"
													value={keySearchInput}
													onValueChange={(e) => setKeySearchInput(e)}
												/>
												<CommandList>
													<CommandEmpty />
													<CommandGroup>
														{metadataKeys &&
															[
																"Id",
																"Message",
																"Level",
																...metadataKeys,
															]
																.filter((key) =>
																	key
																		.toLowerCase()
																		.includes(
																			keySearchInput.toLowerCase()
																		)
																)
																.slice(0, 5)
																.map((key) => (
																	<CommandItem
																		className="capitalize"
																		key={key}
																		value={key}
																		onSelect={(v) => {
																			field.onChange(v);
																			setKeyOpen(false);
																		}}
																	>
																		<Check
																			className={cn(
																				key === field.value
																					? "opacity-100"
																					: "opacity-0"
																			)}
																		/>
																		{toFlatCase(key)}
																	</CommandItem>
																))}
													</CommandGroup>
												</CommandList>
											</Command>
										</PopoverContent>
									</Popover>
									<FormDescription>
										The key you would like to search for the given value in.
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
										open={operatorOpen}
										onOpenChange={setOperatorOpen}
										onValueChange={field.onChange}
										defaultValue={field.value}
									>
										<FormControl>
											<SelectTrigger className="capitalize">
												<SelectValue placeholder="Select Key" />
											</SelectTrigger>
										</FormControl>
										<SelectContent>
											<SelectItem value={"contains"}>Contains</SelectItem>
											<SelectItem value={"equals"}>Equals (=)</SelectItem>
											<SelectItem value={"notEquals"}>
												Not Equals (!=)
											</SelectItem>
										</SelectContent>
									</Select>
									<FormDescription>
										The operator for this filter, like "resource" = "nyx-core"
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
										<Input placeholder="nyx-core" {...field} />
									</FormControl>
									<FormDescription>
										The value you wish to search for.
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>
						<Button className="w-full" type="submit">
							Add Filter
						</Button>
					</form>
				</Form>
			</PopoverContent>
		</Popover>
	);
}
