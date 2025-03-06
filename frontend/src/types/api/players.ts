export type TPlayer = {
	citizenId: string;
	license: string;
	name: string;
	phoneNumber: string;
	charInfo: TCharInfo;
	money: TCharMoney;
	gang: TGang;
	job: TJob;
};

type TCharInfo = {
	phone: string;
	nationality: string;
	lastname: string;
	gender: number;
	account: string;
	cid: number;
	birthdate: string; // ISO 8601 format
	firstname: string;
};

type TCharMoney = {
	cash: number;
	bank: number;
	crypto: number;
};

type TGrade = {
	name: string;
	level: number;
};

type TGang = {
	label: string;
	name: string;
	isBoss: boolean;
	grade: TGrade;
};

type TJob = {
	onDuty: boolean;
	name: string;
	grade: TGrade;
	label: string;
	isBoss: boolean;
	type: string;
	payment: number;
};
