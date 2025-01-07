import WouterProvider from "@/components/router/wouter-provider";
import { Route } from "wouter";
import LoginPage from "./pages/Login";
import PrivateRoute from "./components/router/private-route";
import DashboardHome from "./pages/Dashboard";
import UserDebugPage from "./pages/Dashboard/UserDebug";
import RoleSettingsPage from "./pages/Dashboard/Settings/Roles";
import UsersSettingsPage from "./pages/Dashboard/Settings/Users";

function App() {
	return (
		<WouterProvider>
			<Route path={"/login"} component={LoginPage} />
			<PrivateRoute path={"/"} component={DashboardHome} />
			<PrivateRoute path={"/user-debug"} component={UserDebugPage} />
			<PrivateRoute path={"/settings/roles"} component={RoleSettingsPage} />
			<PrivateRoute path={"/settings/users"} component={UsersSettingsPage} />
			<PrivateRoute>404</PrivateRoute>
		</WouterProvider>
	);
}

export default App;
