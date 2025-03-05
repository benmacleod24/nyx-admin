import { Button } from "@/components/ui/button";
import {
	Form,
	FormControl,
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
import { useAuth, useCopyToClipboard } from "@/hooks";
import { Fetch } from "@/lib";
import { ApiEndponts, Permissions } from "@/lib/config";
import { TUser } from "@/types";
import { useAutoAnimate } from "@formkit/auto-animate/react";
import { zodResolver } from "@hookform/resolvers/zod";
import { ArrowRight, Check, Copy, Loader, Plus, ShieldAlertIcon } from "lucide-react";
import { useState } from "react";
import { useForm } from "react-hook-form";
import { mutate } from "swr";
import { z } from "zod";

type FormSchema = z.infer<typeof formSchema>;
const formSchema = z.object({
	username: z.string(),
	password: z.ostring(),
});

export default function CreateUser() {
	const [isOpen, setIsOpen] = useState<boolean>(false);
	const { hasPermission } = useAuth();
	const [rootAnimateRef] = useAutoAnimate();
	const [copyAnimateRef] = useAutoAnimate();
	const [copiedText, copy] = useCopyToClipboard();
	const [registeredUser, setRegisteredUser] = useState<(TUser & { password: string }) | null>(
		null
	);

	const form = useForm<FormSchema>({
		resolver: zodResolver(formSchema),
	});

	async function onSubmit(values: FormSchema) {
		const resp = await Fetch.Post<TUser & { password: string }>(ApiEndponts.Auth.Register, {
			includeCredentials: true,
			body: values,
		});

		if (!resp.ok) {
			form.setError("root", { message: resp.message || "Internal Server Error" });
			return;
		}

		if (resp.data) {
			setRegisteredUser(resp.data);
			mutate(ApiEndponts.User.GetAllUsers);
		}
	}

	async function copyRegisteredUserDetails() {
		if (!registeredUser) return;
		await copy(`Username: ${registeredUser.userName}\nPassword: ${registeredUser.password}`);
	}

	if (!hasPermission(Permissions.CreateUsers)) return;

	return (
		<ResponsiveModal open={isOpen} onOpenChange={setIsOpen}>
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
					<ResponsiveModalTitle>Register User</ResponsiveModalTitle>
					<ResponsiveModalDescription>
						Create a new registered user.
					</ResponsiveModalDescription>
				</ResponsiveModalHeader>

				<Form {...form}>
					<form
						onSubmit={form.handleSubmit(onSubmit)}
						className="grid gap-4"
						ref={rootAnimateRef}
					>
						<FormField
							control={form.control}
							name="username"
							render={({ field }) => (
								<FormItem>
									<FormLabel>
										Username<span className="text-red-500">*</span>
									</FormLabel>
									<FormControl>
										<Input placeholder="jscott" {...field} />
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>
						<FormField
							control={form.control}
							name="password"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Password</FormLabel>
									<FormControl>
										<Input
											type="password"
											placeholder="••••••••••"
											{...field}
										/>
									</FormControl>
									<FormMessage />
								</FormItem>
							)}
						/>

						{/* Form Root Error */}
						{form.formState.errors.root && (
							<div className="border border-red-500 rounded-lg p-3 text-red-500 bg-red-200/20 flex items-center gap-2">
								<ShieldAlertIcon />
								<p>{form.formState.errors.root.message}</p>
							</div>
						)}

						{/* Registered User Block */}
						{registeredUser && (
							<div>
								<div className="p-3 border rounded-lg bg-muted/50">
									<div className="flex items-center justify-between mb-2">
										<h3 className="font-medium">User Details</h3>
										<Button
											size={"icon"}
											variant={"ghost"}
											className="w-fit h-fit p-1.5"
											type="button"
											onClick={copyRegisteredUserDetails}
											ref={copyAnimateRef}
										>
											{!copiedText ? (
												<Copy />
											) : (
												<Check className="text-green-500" />
											)}
										</Button>
									</div>
									<p className="text-sm font-medium">
										Username:{" "}
										<span className="font-mono text-muted-foreground">
											{registeredUser.userName}
										</span>
									</p>
									<p className="text-sm font-medium">
										Password:{" "}
										<span className="font-mono text-muted-foreground">
											{registeredUser.password}
										</span>
									</p>
								</div>
								<p className="text-sm text-muted-foreground mt-1 ml-1">
									Share these details with the user and then forget the password.
									Click the copy button in the top-right.
								</p>
							</div>
						)}

						{/* Footer */}
						<div className="flex items-center justify-end gap-3 mt-3">
							<ResponsiveModalClose asChild>
								<Button variant={"outline"}>Cancel</Button>
							</ResponsiveModalClose>
							<Button>
								Register{" "}
								{form.formState.isSubmitting ? (
									<Loader className="animate-spin" />
								) : (
									<ArrowRight />
								)}
							</Button>
						</div>
					</form>
				</Form>
			</ResponsiveModalContent>
		</ResponsiveModal>
	);
}
