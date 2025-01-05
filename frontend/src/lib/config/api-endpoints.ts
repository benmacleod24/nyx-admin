import { User } from "lucide-react";

export const ApiEndponts = {
	Auth: {
		Refresh: "/api/auth/refresh",
		Login: "/api/auth/login",
	},
	Permissions: {
		Get: "/api/permissions",
	},
	User: {
		GetPermissions: "/api/user/permissions",
	},
	Roles: {
		Create: "/api/roles",
		GetPermissions: (roleKey: string) => `/api/roles/${roleKey}/permissions`,
		UpdateOrder: "/api/roles/update-order",
		GetRoles: "/api/roles",
	},
} as const;
