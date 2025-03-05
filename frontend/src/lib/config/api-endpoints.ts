import { User } from "lucide-react";

export const ApiEndponts = {
	Auth: {
		Refresh: "/api/auth/refresh",
		Login: "/api/auth/login",
		Register: "/api/auth/register",
		Logout: "/api/auth/logout",
	},
	Permissions: {
		Get: "/api/permissions",
	},
	User: {
		GetPermissions: "/api/user/permissions",
		GetAllUsers: "/api/users",
	},
	Logs: {
		GetAllLogs: "/api/logs",
		MetadataKeys: "/api/logs/metadata/keys",
		Search: "/api/logs/search",
		GetLogById: (v: string) => `/api/logs/${v}`,
	},
	Users: {
		UpdateUser: (userId: string) => `/api/users/${userId}`,
	},
	Roles: {
		Create: "/api/roles",
		GetPermissions: (roleKey: string) => `/api/roles/${roleKey}/permissions`,
		UpdateOrder: "/api/roles/update-order",
		GetRoles: "/api/roles",
		AddPermission: (roleKey: string, permissionId: number) =>
			`/api/roles/${roleKey}/permissions/${permissionId}`,
		RemovePermission: (roleKey: string, permissionId: number) =>
			`/api/roles/${roleKey}/permissions/${permissionId}`,
		DeleteRole: (roleKey: string) => `/api/roles/${roleKey}`,
	},
	Players: {
		Search: "/api/players/search",
		Get: (citizenId: string) => `/api/players/${citizenId}`,
	},
	TableColumns: {
		Get: (tableKey: string) => `/api/tablecolumns/${tableKey}`,
	},
} as const;
