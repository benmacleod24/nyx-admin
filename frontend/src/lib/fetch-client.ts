import { THttpMethods } from "@/types";
import { authTokenAtom, globalStore } from "./state";

export type fetchWrapperOptions<TBody = unknown> = {
	method: THttpMethods;
	body?: TBody | unknown;
	includeCredentials?: boolean;
};

export async function fetchWrapper<TResponse = any, TBody = unknown>(
	uri: string,
	options: fetchWrapperOptions<TBody>
) {
	// Build the fetch request options.
	let requestOptions: RequestInit = {
		method: options.method,
		credentials: "include",
		headers: {
			["Content-Type"]: "application/json",
		},
	};

	// Include auth token in request.
	if (options.includeCredentials) {
		const authToken = globalStore.get(authTokenAtom);

		if (authToken) {
			// Push token to request headers.
			requestOptions.headers = {
				...requestOptions.headers,
				["Authorization"]: `Bearer ${authToken}`,
			};
		}
	}

	// If a body exist and method supports attach body.
	if (options.body && options.method !== "GET") {
		requestOptions.body = JSON.stringify(options.body);
	}

	try {
		const response = await fetch(`https://localhost:7252${uri}`, requestOptions);

		const contentType = response.headers.get("Content-Type");
		if (contentType && contentType.includes("application/json")) {
			// Parse the json
			const data = await response.json();

			// Return error message.
			if (!response.ok && data && data.message) {
				return {
					ok: response.ok,
					message: data.message,
				};
			}

			// Return data.
			return {
				ok: response.ok,
				data: data as TResponse,
			};
		}

		return {
			ok: response.ok,
			data: undefined,
		};
	} catch (e) {
		return { ok: false, data: undefined };
	}

	return { ok: false };
}

export const Fetch = {
	Get: <R>(uri: string, options?: Omit<fetchWrapperOptions, "method">) =>
		fetchWrapper<R>(uri, { ...options, method: "GET" }),
	Post: <R, B = unknown>(uri: string, options?: Omit<fetchWrapperOptions<B>, "method">) =>
		fetchWrapper<R, B>(uri, { ...options, method: "POST" }),
	Patch: <R, B = unknown>(uri: string, options?: Omit<fetchWrapperOptions<B>, "method">) =>
		fetchWrapper<R, B>(uri, { ...options, method: "PATCH" }),
	Put: <R, B = unknown>(uri: string, options?: Omit<fetchWrapperOptions<B>, "method">) =>
		fetchWrapper<R, B>(uri, { ...options, method: "PUT" }),
	Delete: <R, B = unknown>(uri: string, options?: Omit<fetchWrapperOptions<B>, "method">) =>
		fetchWrapper<R, B>(uri, { ...options, method: "DELETE" }),
};
