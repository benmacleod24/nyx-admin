export const ApiEndponts = {
	Auth: {
		Refresh: "/api/auth/refresh",
		Login: "/api/auth/login",
	},
	Permissions: {
		Get: "/api/permissions",
	},
	Roles: {
		Create: "/api/roles",
		GetPermissions: (roleKey: string) => `/api/roles/${roleKey}/permissions`,
	},
} as const;
