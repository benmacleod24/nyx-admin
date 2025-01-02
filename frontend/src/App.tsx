import WouterProvider from "@/components/router/wouter-provider";
import AuthInit from "./components/auth-init";
import { Route } from "wouter";
import LoginPage from "./pages/Login";
import React from "react";
import PrivateRoute from "./components/router/private-route";
import DashboardHome from "./pages/Dashboard";

function App() {
	return (
		<React.Fragment>
			<AuthInit />
			<WouterProvider>
				<Route path={"/login"} component={LoginPage} />
				<PrivateRoute path={"/"} component={DashboardHome} />
				<PrivateRoute>404</PrivateRoute>
			</WouterProvider>
		</React.Fragment>
	);
}

export default App;
