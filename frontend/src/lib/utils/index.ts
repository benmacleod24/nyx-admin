import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
	return twMerge(clsx(inputs));
}

export function toFlatCase(input: string): string {
	return input
		.replace(/([a-z])([A-Z])/g, "$1 $2") // Convert camelCase to words with spaces
		.replace(/[_\s]+/g, " ") // Replace underscores or multiple spaces with a single space
		.toLowerCase(); // Convert to lowercase
}

export const shuffle = (array: any[]) => {
	for (let i = array.length - 1; i > 0; i--) {
		const j = Math.floor(Math.random() * (i + 1));
		[array[i], array[j]] = [array[j], array[i]];
	}
	return array;
};

export function capitalize(val: string) {
	return String(val).charAt(0).toUpperCase() + String(val).slice(1);
}

export function formatPhoneNumber(phone: string): string {
	// Remove all non-numeric characters
	const digits = phone.replace(/\D/g, "");

	// Check if the number has a valid length (e.g., US numbers with 10 or 11 digits)
	if (digits.length === 10) {
		return `${digits.slice(0, 3)}.${digits.slice(3, 6)}.${digits.slice(6)}`;
	} else if (digits.length === 11 && digits.startsWith("1")) {
		return `+1 (${digits.slice(1, 4)}) ${digits.slice(4, 7)}-${digits.slice(7)}`;
	}

	// Return the original if it doesn't match a known format
	return phone;
}

export function isStringNumber(str: string) {
	const _isNan = isNaN(parseInt(str));
	return !_isNan;
}

export function getNestedValue<T>(obj: any, path: string): T | undefined {
	return path.split(".").reduce((acc, key) => acc && acc[key], obj);
}

export * from "./to-query";
