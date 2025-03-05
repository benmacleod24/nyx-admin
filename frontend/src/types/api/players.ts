export type TPlayer = {
	citizenId: string;
	license: string;
	name: string;
	charInfo: {
		phone: string;
		nationality: string;
		lastname: string;
		gender: number;
		account: string;
		cid: number;
		birthdate: string;
		firstname: string;
	};
	money: {
		cash: number;
		bank: number;
		crypto: number;
	};
	phoneNumber: string;
};
