import { formatPhoneNumber } from "@/lib/utils";
import dayjs from "dayjs";

export type PlayerColumn = {
	title: string;
	map: string;
	size?: number;
	formatter?: (v: string) => string;
};

// Columns the user can toggle to be visible on the players search table.
// Map = the key of the object so charInfo.firstname is equal to player[charInfo][firstname]
export const allowedPlayersColumns: PlayerColumn[] = [
	{
		title: "Citizen ID",
		map: "citizenId",
	},
	{
		title: "First Name",
		map: "charInfo.firstname",
	},
	{
		title: "Last Name",
		map: "charInfo.lastname",
	},
	{
		title: "Played By",
		map: "playedBy",
	},
	{
		title: "License",
		map: "license",
	},
	{
		title: "Cash",
		map: "money.cash",
		formatter: (v) => `$${parseInt(v).toLocaleString()}`,
	},
	{
		title: "Bank",
		map: "money.bank",
		formatter: (v) => `$${parseInt(v).toLocaleString()}`,
	},
	{
		title: "Crypto",
		map: "money.crypto",
		formatter: (v) => parseInt(v).toLocaleString(),
	},
	{
		title: "Phone Number",
		map: "phoneNumber",
		formatter: formatPhoneNumber,
		size: 200,
	},
	{
		title: "Gender",
		map: "charInfo.gender",
		formatter: JSON.stringify,
	},
	{ title: "Account", map: "charInfo.account", size: 220 },
	{
		title: "Birth Date",
		map: "charInfo.birthdate",
		formatter: (v) => dayjs(v).format("MMM DD, YYYY"),
	},
	{ title: "Nationality", map: "charInfo.nationality" },
	{ title: "Job Boss", map: "job.isboss", formatter: JSON.stringify },
	{ title: "Job Name", map: "job.name" },
	{ title: "Job Label", map: "job.label" },
	{ title: "Job Type", map: "job.type" },
	{ title: "Job Pay", map: "job.payment", formatter: (v) => `$${parseInt(v).toLocaleString()}` },
	{ title: "Job Duty", map: "job.onduty", formatter: JSON.stringify },
	{ title: "Job Level", map: "job.grade.level" },
	{ title: "Job Level Name", map: "job.grade.name" },
	{ title: "Gang Name", map: "gang.name" },
	{ title: "Is Gang Boss", map: "gang.isboss", formatter: (v) => (v ? "true" : "false") },
	{ title: "Gang Level", map: "gang.grade.level" },
	{ title: "Gang Level Name", map: "gang.grade.name" },
	{ title: "Gang Label", map: "gang.label" },
];
