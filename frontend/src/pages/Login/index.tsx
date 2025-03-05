import { Button } from "@/components/ui/button";
import { Form, FormControl, FormField, FormItem, FormLabel } from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { zodResolver } from "@hookform/resolvers/zod";
import { useForm } from "react-hook-form";
import { ArrowRight, Loader, ShieldAlert } from "lucide-react";
import { z } from "zod";
import { Fetch } from "@/lib";
import { ApiEndponts } from "@/lib/config";
import { TAuthResponse } from "@/types";
import { useAtom, useSetAtom } from "jotai";
import { authTokenAtom } from "@/lib/state";
import { userAtom } from "@/lib/state/user";
import { useLocation } from "wouter";
import { useAuth, useSearchParam } from "@/hooks";

type FormSchema = z.infer<typeof formSchema>;
const formSchema = z.object({
	username: z.string(),
	password: z.string(),
});

export default function LoginPage() {
	const [authToken, setAuthToken] = useAtom(authTokenAtom);
	const { isLoading } = useAuth();
	const setUser = useSetAtom(userAtom);
	const [_, navigate] = useLocation();
	const redirect = useSearchParam("redirect");

	const form = useForm<FormSchema>({
		resolver: zodResolver(formSchema),
	});

	async function onSubmit(values: FormSchema) {
		const res = await Fetch.Post<TAuthResponse>(ApiEndponts.Auth.Login, {
			body: values,
		});

		if (res.ok && res.data) {
			setAuthToken(res.data.authToken);
			setUser(res.data.data);
			navigate(redirect === "" || !redirect ? "/" : redirect);
		} else {
			form.setError("root", { message: res.message || "Internal Service Error" });
		}
	}

	if (isLoading) return;

	if (!isLoading && authToken) {
		navigate(redirect ?? "/");
		return;
	}

	return (
		<div className="w-screen h-dvh flex items-center justify-center flex-col gap-3">
			<div className="max-w-[25rem] rounded-lg overflow-hidden border relative">
				<img
					className="w-full h-full object-cover object-center grayscale"
					src="./banner.png"
				/>
				<div className="absolute top-0 left-0 w-full h-full bg-gradient-to-tr from-brand/50 via-brand/20 to-brand/10" />
			</div>
			<div className="rounded-lg border p-6 w-[25rem]">
				<div className="flex flex-col">
					<h1 className="text-xl font-bold">Welcome Back!</h1>
					<p className="text-muted-foreground text-sm">Login to your NYX Admin Account</p>
				</div>
				<Form {...form}>
					<form onSubmit={form.handleSubmit(onSubmit)} className="mt-5 grid gap-3">
						<FormField
							control={form.control}
							name="username"
							render={({ field }) => (
								<FormItem>
									<FormLabel>Username</FormLabel>
									<FormControl>
										<Input placeholder="jamesscott" {...field} />
									</FormControl>
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
										<Input type="password" placeholder="•••••••••" {...field} />
									</FormControl>
								</FormItem>
							)}
						/>
						{form.formState.errors.root && (
							<div className="bg-red-400/30 rounded-lg p-2 text-red-300 text-sm border border-red-500 flex items-center gap-2">
								<ShieldAlert />
								<p>{form.formState.errors.root.message}</p>
							</div>
						)}
						<Button className="w-full gap-3 mt-5">
							Login{" "}
							{form.formState.isSubmitting ? (
								<Loader className="animate-spin" />
							) : (
								<ArrowRight />
							)}
						</Button>
					</form>
				</Form>
			</div>
		</div>
	);
}
