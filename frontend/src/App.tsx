import WouterProvider from "@/components/router/wouter-provider";
import { Route } from "wouter";
import LoginPage from "./pages/Login";
import PrivateRoute from "./components/router/private-route";
import DashboardHome from "./pages/Dashboard/Home";
import UserDebugPage from "./pages/Dashboard/UserDebug";
import RoleSettingsPage from "./pages/Dashboard/Settings/Roles";
import UsersSettingsPage from "./pages/Dashboard/Settings/Users";
import LogsPage from "./pages/Dashboard/Logs";
import CitizensPage from "./pages/Dashboard/Citizens";
import CitizenPage from "./pages/Dashboard/Citizen";
import SettingsGeneral from "./pages/Dashboard/Settings/General";
import CitizenRemarksPage from "./pages/Dashboard/Citizen/Remarks";

function App() {
	return (
		<WouterProvider>
			<Route path={"/login"} component={LoginPage} />
			<PrivateRoute path={"/"} component={DashboardHome} />
			<PrivateRoute path={"/citizens"} component={CitizensPage} />
			<PrivateRoute path={"/citizens/:id"} component={CitizenPage} />
			<PrivateRoute path={"/citizens/:id/remarks"} component={CitizenRemarksPage} />
			<PrivateRoute path={"/logs"} component={LogsPage} />
			<PrivateRoute path={"/user-debug"} component={UserDebugPage} />
			<PrivateRoute path={"/settings"} component={SettingsGeneral} />
			<PrivateRoute path={"/settings/roles"} component={RoleSettingsPage} />
			<PrivateRoute path={"/settings/users"} component={UsersSettingsPage} />
			<PrivateRoute>404</PrivateRoute>
		</WouterProvider>
	);
}

export default App;
