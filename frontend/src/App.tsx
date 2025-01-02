import WouterProvider from "@/components/router/wouter-provider";
import AuthInit from "./components/auth-init";
import { Route, Switch } from "wouter";
import LoginPage from "./pages/Login";
import React from "react";
import PrivateRoute from "./components/router/private-route";
import DashboardHome from "./pages/Dashboard";
import UserDebugPage from "./pages/Dashboard/UserDebug";
import SystemSettings from "./pages/Dashboard/Settings/System";

function App() {
	return (
		<React.Fragment>
			<AuthInit />
			<WouterProvider>
				<Route path={"/login"} component={LoginPage} />
				<PrivateRoute path={"/"} component={DashboardHome} />
				<PrivateRoute path={"/user-debug"} component={UserDebugPage} />
				<PrivateRoute
					path={"/settings/system"}
					component={SystemSettings}
				/>
				<PrivateRoute>404</PrivateRoute>
			</WouterProvider>
		</React.Fragment>
	);
}

export default App;
