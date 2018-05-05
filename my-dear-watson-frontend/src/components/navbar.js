import React, { Component } from "react";
import { NavLink, withRouter } from "react-router-dom";
import { Menu, Segment, Icon } from "semantic-ui-react";

class Navbar extends Component {
	state = { activeItem: "" };

	static getDerivedStateFromProps(nextProps, prevState) {
		if (nextProps.location.pathname === "/start") {
			return { activeItem: "start" };
		} else if (nextProps.location.pathname === "/start") {
			return { activeItem: "home" };
		} else {
			return { activeItem: "" };
		}
	}

	render() {
		const { activeItem } = this.state;

		return (
			<Segment inverted>
				<Menu secondary inverted>
					<Menu.Item
						name="home"
						active={activeItem === "home"}
						as={NavLink}
						to="/"
						exact
					>
						<h3>My Dear Watson</h3>
					</Menu.Item>
					<Menu.Item
						name="start"
						active={activeItem === "start"}
						as={NavLink}
						to="/start"
						exact
					>
						<Icon color={"purple"} size={"big"} name="search" />
					</Menu.Item>
				</Menu>
			</Segment>
		);
	}
}

export default withRouter(Navbar);
