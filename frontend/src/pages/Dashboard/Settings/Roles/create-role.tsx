import { Button } from "@/components/ui/button";
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
import {
	ResponsiveModal,
	ResponsiveModalClose,
	ResponsiveModalContent,
	ResponsiveModalDescription,
	ResponsiveModalHeader,
	ResponsiveModalTitle,
	ResponsiveModalTrigger,
} from "@/components/ui/responsive-modal";
import { useAuth } from "@/hooks";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TRole } from "@/types";
import { zodResolver } from "@hookform/resolvers/zod";
import { ArrowRight, Loader, Plus } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { mutate } from "swr";
import { z } from "zod";

type FormSchema = z.infer<typeof formSchema>;
const formSchema = z.object({
	key: z.string(),
	friendlyName: z.string(),
});

export default function CreateRole() {
	const [open, setOpen] = useState<boolean>(false);
	const { hasPermission } = useAuth();

	const form = useForm<FormSchema>({
		resolver: zodResolver(formSchema),
	});

	async function onSubmit(values: FormSchema) {
		const response = await Fetch.Post<TRole>(ApiEndponts.Roles.Create, {
			body: values,
			includeCredentials: true,
		});

		if (response.ok && response.data) {
			await mutate("/api/roles", response.data);
			setOpen(false);
		} else {
			form.setError("root", {
				message: response.message,
			});
		}
	}

	if (!hasPermission(Permissions.CreateRole)) return;

	return (
		<ResponsiveModal open={open} onOpenChange={setOpen}>
			<ResponsiveModalTrigger asChild>
				<Button
					size={"icon"}
					variant={"outline"}
					className="items-center min-w-10 min-h-10 justify-center rounded-lg"
				>
					<Plus />
				</Button>
			</ResponsiveModalTrigger>
			<ResponsiveModalContent side={"bottom"}>
				<ResponsiveModalHeader>
					<ResponsiveModalTitle>Create Role</ResponsiveModalTitle>
					<ResponsiveModalDescription>
						Create a new role to assign to users.
					</ResponsiveModalDescription>
				</ResponsiveModalHeader>

				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="grid gap-4">
						<FormField
							control={form.control}
							name="key"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Role Key</FormLabel>
									<FormControl>
										<Input placeholder="SUPER_ADMIN" {...field} />
									</FormControl>
									<FormDescription>
										Keys must be uppercase with spaces as underscores.
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="friendlyName"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Friendly Name</FormLabel>
									<FormControl>
										<Input placeholder="Super Admin" {...field} />
									</FormControl>
									<FormDescription>
										Assign a friendly name to the role to make it easy to read.
									</FormDescription>
									<FormMessage />
								</FormItem>
							)}
						/>
						<div className="flex items-center justify-end gap-3 mt-3">
							<Button>
								Create{" "}
								{form.formState.isSubmitting ? (
									<Loader className="animate-spin" />
								) : (
									<ArrowRight />
								)}
							</Button>
							<ResponsiveModalClose asChild>
								<Button variant={"outline"}>Cancel</Button>
							</ResponsiveModalClose>
						</div>
					</form>
				</Form>
			</ResponsiveModalContent>
		</ResponsiveModal>
	);
}
