import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import {
	Header,
	Container,
	Button,
	Icon,
	Segment,
	Divider
} from "semantic-ui-react";

class Homepage extends Component {
	componentDidMount() {
		window.scrollTo(0, 0);
	}

	handleClick = () => {
		this.props.history.push("/start");
	};

	render() {
		return (
			<div>
				<Segment
					inverted
					textAlign="center"
					style={{ minHeight: 700, padding: "1em 0em", margin: "-40px -10px" }}
					vertical
				>
					<Container text>
						<Header
							as="h1"
							content="My Dear Watson"
							inverted
							style={{
								fontSize: "4em",
								fontWeight: "normal",
								marginBottom: 0,
								marginTop: "3em"
							}}
						/>
						<Header
							as="h2"
							content="Analyze Twitter personas from Big Five personality traits to likely preferences in music."
							inverted
							style={{
								fontSize: "1.7em",
								fontWeight: "normal",
								marginTop: "1.5em"
							}}
						/>
						<Button primary onClick={this.handleClick} size="huge">
							Get Started
							<Icon name="right arrow" />
						</Button>
					</Container>
				</Segment>
				<Segment style={{ padding: "8em 0em" }} vertical>
					<Container text>
						<Header as="h3" style={{ fontSize: "2em" }}>
							Ever wondered how intellectual they really are?
						</Header>
						<p style={{ fontSize: "1.33em" }}>
							With My Dear Watson dive into the personas of your favorite (or
							least favorite) twitter users. Know not only if they value modesty
							or are likely to have gym memberships, but even compare them to
							the average twitter persona searched.
						</p>
						<Button onClick={this.handleClick} size="large">
							Select a Twitter User
						</Button>
						<Divider
							as="h4"
							className="header"
							horizontal
							style={{ margin: "3em 0em", textTransform: "uppercase" }}
						>
							<a
								target="_blank"
								rel="noopener noreferrer"
								href="https://twitter.com/"
							>
								<Icon name="twitter" />
								Powered by Twitter
							</a>
						</Divider>
						<Header as="h3" style={{ fontSize: "2em" }}>
							Made possible by IBM Watson Personality Insights
						</Header>
						<p style={{ fontSize: "1.33em" }}>
							"Predict personality characteristics, needs and values through
							[tweets]. Understand [users'] habits and preferences on an
							individual level, and at scale."
						</p>
						<Button
							as="a"
							size="large"
							target="_blank"
							rel="noopener noreferrer"
							href="https://www.ibm.com/watson/services/personality-insights/"
						>
							Read More from IBM
						</Button>
					</Container>
					<Button
						onClick={this.handleClick}
						size="massive"
						color="orange"
						style={{ margin: "3em 0em 0em" }}
					>
						Start Analyzing
						<Icon name="right arrow" />
					</Button>
				</Segment>
			</div>
		);
	}
}

export default withRouter(Homepage);
