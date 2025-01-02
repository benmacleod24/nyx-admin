import { TUser } from "../user";

export type TAuthResponse = {
	authToken: string;
	data: TUser;
};
