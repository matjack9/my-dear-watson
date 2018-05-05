import React, { Component } from "react";
import { Switch, Route, withRouter } from "react-router-dom";
import Homepage from "./components/homepage";
import Start from "./containers/start";
import Analysis from "./containers/analysis";
import "./styles/App.css";

class App extends Component {
	state = {
		accounts: []
	};

	setAccounts = accounts => {
		this.setState({ accounts });
	};

	StartPage = props => {
		return (
			<Start
				accounts={this.state.accounts}
				setAccounts={this.setAccounts}
				{...props}
			/>
		);
	};

	render() {
		return (
			<div className="App">
				<Switch>
					<Route exact path="/" component={Homepage} />
					<Route exact path="/start" render={this.StartPage} />
					<Route exact path="/analysis/:id/:attribute" component={Analysis} />
				</Switch>
			</div>
		);
	}
}

export default withRouter(App);
