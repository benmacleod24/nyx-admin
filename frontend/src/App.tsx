import WouterProvider from "@/components/router/wouter-provider";
import { Route } from "wouter";
import LoginPage from "./pages/Login";
import PrivateRoute from "./components/router/private-route";
import DashboardHome from "./pages/Dashboard";
import UserDebugPage from "./pages/Dashboard/UserDebug";
import RoleSettingsPage from "./pages/Dashboard/Settings/Roles";
import UsersSettingsPage from "./pages/Dashboard/Settings/Users";
import LogsPage from "./pages/Dashboard/Logs";
import PlayersPage from "./pages/Dashboard/Players";
import PlayerPage from "./pages/Dashboard/Player";
import SettingsGeneral from "./pages/Dashboard/Settings/General";

function App() {
	return (
		<WouterProvider>
			<Route path={"/login"} component={LoginPage} />
			<PrivateRoute path={"/"} component={DashboardHome} />
			<PrivateRoute path={"/players"} component={PlayersPage} />
			<PrivateRoute path={"/players/:id"} component={PlayerPage} />
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
