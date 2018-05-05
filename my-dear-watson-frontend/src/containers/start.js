import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { fetchTwitterAccounts, postTwitterAccount } from "../services";
import Loading from "../components/loading";
import PropTypes from "prop-types";
import uuid from "uuid";
import {
	Button,
	Form,
	Grid,
	Header,
	Segment,
	Icon,
	Message
} from "semantic-ui-react";

class Start extends Component {
	state = {
		isLoadingComplete: false,
		options: []
	};

	componentDidMount() {
		window.scrollTo(0, 0);
		fetchTwitterAccounts()
			.then(res => {
				if (res) {
					this.props.setAccounts(res.data);
				}
			})
			.then(() => this.setState({ isLoadingComplete: true }));
	}

	static getDerivedStateFromProps(nextProps, prevState) {
		if (nextProps.accounts.length > prevState.options.length) {
			let options = nextProps.accounts.map(a => ({
				key: uuid(),
				text: a.handle,
				value: a.id
			}));

			options.sort((a, b) => {
				let textA = a.text.toUpperCase();
				let textB = b.text.toUpperCase();

				return textA.localeCompare(textB);
			});

			return { options };
		}
		return null;
	}

	handleAddition = (e, { value }) => {
		if (this._isTwitterHandleValid(value)) {
			this.setState({
				options: [{ key: uuid(), text: value, value }, ...this.state.options]
			});
		} else {
			alert("Please confirm the twitter handle is in a valid format");
		}
	};

	handleChange = (e, { value }) => this.setState({ currentValue: value });

	handleSubmit = e => {
		e.preventDefault();
		if (!this.state.currentValue) {
			alert("Please enter a twitter handle");
		} else if (typeof this.state.currentValue === "number") {
			// if the value is a number, the handle is in the database
			const analysisUrl = `/analysis/${this.state.currentValue}/personality`;
			this.props.history.push(analysisUrl);
		} else {
			// if the value is a string, the user inputted it for creation
			this.setState({ isLoadingComplete: false });
			postTwitterAccount(this.state.currentValue)
				.then(res => {
					if (res) {
						const analysisUrl = `/analysis/${res.data.id}/personality`;
						this.props.history.push(analysisUrl);
					}
				})
				.then(() => this.setState({ isLoadingComplete: true }));
		}
	};

	_isTwitterHandleValid = twitterHandle => {
		return /^[0-9a-zA-Z_.-]+$/.test(twitterHandle);
	};

	render() {
		const { currentValue } = this.state;
		return !this.state.isLoadingComplete ? (
			<Loading />
		) : (
			<div className="start-form">
				<style>{`
								body > div,
								body > div > div,
								body > div > div > div.start-form {
									height: 100%;
								}
							`}</style>
				<Grid
					textAlign="center"
					style={{ height: "100%", margin: "1em", padding: "1em" }}
				>
					<Grid.Column style={{ maxWidth: 900 }}>
						<Form size="large" onSubmit={this.handleSubmit}>
							<Segment stacked>
								<Form.Field>
									<label style={{ margin: "1em", padding: "1em" }}>
										<Header as="h2" color="black">
											<Icon name="search" />Search Twitter Handles
										</Header>
									</label>
									<Form.Dropdown
										options={this.state.options}
										inline
										placeholder="example: 'dan_abramov'"
										search
										selection
										fluid
										allowAdditions
										additionLabel={""}
										value={currentValue}
										onAddItem={this.handleAddition}
										onChange={this.handleChange}
									/>
								</Form.Field>
								<Form.Field>
									<Button color="orange">Analyze</Button>
								</Form.Field>
							</Segment>
						</Form>
					</Grid.Column>
				</Grid>
				<Message compact ttached="bottom">
					Search through previously searched twitter handles, or enter a new
					handle from&nbsp;<a
						target="_blank"
						rel="noopener noreferrer"
						href="https://twitter.com/search-home?lang=en"
					>
						Twitter
					</a>&nbsp;<Icon name="external" />to analyze.
				</Message>
			</div>
		);
	}
}

Start.propTypes = {
	accounts: PropTypes.array.isRequired
};

export default withRouter(Start);
