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
	Citizens: {
		Search: "/api/citizens/search",
		Get: (citizenId: string) => `/api/citizens/${citizenId}`,
		GetRelatedCitizens: (citizenId: string) => `/api/citizens/${citizenId}/related-citizens`,
	},
	TableColumns: {
		Get: (tableKey: string) => `/api/tablecolumns/${tableKey}`,
	},
	Remarks: {
		Get: (license: string) => `/api/remarks/${license}`,
		GetByCitizenId: (citizenId: string) => `/api/remarks/citizen/${citizenId}`,
		Create: `/api/remarks`,
	},
	Reports: {
		EconomyOverview: "/api/reports/economy",
	},
} as const;
