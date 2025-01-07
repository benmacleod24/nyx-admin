import { User } from "lucide-react";

export const ApiEndponts = {
	Auth: {
		Refresh: "/api/auth/refresh",
		Login: "/api/auth/login",
		Register: "/api/auth/register",
	},
	Permissions: {
		Get: "/api/permissions",
	},
	User: {
		GetPermissions: "/api/user/permissions",
		GetAllUsers: "/api/users",
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
} as const;
