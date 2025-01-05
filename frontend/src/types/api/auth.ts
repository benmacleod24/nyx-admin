import { TUser } from "../user";

export type TAuthResponse = {
	authToken: string;
	data: TUser;
};

export type TRole = {
	id: number;
	key: string;
	orderLevel: number;
	friendlyName: string;
};
