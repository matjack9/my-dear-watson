import React from "react";
import { withRouter } from "react-router-dom";
import { Segment, Divider, Container, List, Image } from "semantic-ui-react";
import "../styles/footer.css";

const Footer = () => {
	return (
		<Segment
			className="footer-container"
			inverted
			vertical
			style={{ margin: "5em 0em 0em", padding: "5em 0em" }}
		>
			<Container textAlign="center">
				<Image
					centered
					size="mini"
					src={window.location.origin + "/assets/brain.png"}
				/>
				<Divider inverted />
				<List horizontal inverted divided link>
					<List.Item as="a" href="/">
						Home
					</List.Item>
					<List.Item
						as="a"
						target="_blank"
						rel="noopener noreferrer"
						href="https://www.ibm.com/watson/services/personality-insights/"
					>
						IBM Watson
					</List.Item>
					<List.Item
						as="a"
						target="_blank"
						rel="noopener noreferrer"
						href="https://github.com/matjack9"
					>
						Github
					</List.Item>
					<List.Item
						as="a"
						target="_blank"
						rel="noopener noreferrer"
						href="https://www.linkedin.com/in/matjack/"
					>
						LinkedIn
					</List.Item>
				</List>
			</Container>
		</Segment>
	);
};

export default withRouter(Footer);
