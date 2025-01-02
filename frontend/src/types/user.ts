import { TRole } from "./api";

export type TUser = {
	id: number;
	email?: string;
	userName: string;
	role?: TRole;
};
