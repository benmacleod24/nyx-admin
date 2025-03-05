export type TLog = {
	id: number;
	level: string;
	message: string;
	metadata: Record<string, any>;
	createdAt: Date;
};
