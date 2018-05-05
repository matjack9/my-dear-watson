import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { fetchAccountAttributeAndMetadata } from "../services";
import AnalysisChart from "../components/analysisChart";
import { Tab, Icon, Button, Header, Grid } from "semantic-ui-react";

class Analysis extends Component {
	state = {
		activeIndex: 0,
		twitterHandle: "",
		isPanelLoading: true,
		numberOfHandles: 0,
		analysis: {
			personality: {},
			needs: {},
			values: {},
			"consumption preferences": {}
		},
		analysisAverages: {
			personality: {},
			needs: {},
			values: {},
			"consumption preferences": {}
		},
		analysisDescription: {
			personality: {},
			needs: {},
			values: {},
			"consumption preferences": {}
		}
	};

	static getDerivedStateFromProps(nextProps, prevState) {
		const panes = ["Personality", "Needs", "Values", "Consumption Preferences"];
		// panes must be stubbed otherwise must be in state to be accessed by getDerivedStateFromProps
		const selectedAttribute = nextProps.match.params.attribute.toLowerCase();
		const activeIndex = panes.findIndex(
			p => p.toLowerCase() === selectedAttribute
		);

		if (prevState.activeIndex !== activeIndex) {
			return { activeIndex };
		} else {
			return null;
		}
	}

	componentDidMount() {
		window.scrollTo(0, 0);
		this._loadAsyncAnalysis();
	}

	componentDidUpdate() {
		const selectedAttribute = this.props.match.params.attribute.toLowerCase();
		if (!Object.keys(this.state.analysis[selectedAttribute]).length) {
			this._loadAsyncAnalysis();
		}
	}

	handleTabChange = e => {
		const twitterHandleId = this.props.match.params.id;
		const attribute = e.target.text;

		this.props.history.push(`/analysis/${twitterHandleId}/${attribute}`);
	};

	handleBack = () => {
		this.props.history.push("/start");
	};

	_loadAsyncAnalysis = () => {
		const selectedAttribute = this.props.match.params.attribute.toLowerCase();
		fetchAccountAttributeAndMetadata(
			this.props.match.params.id,
			this._formatFetchAttribute(selectedAttribute)
		).then(res => {
			if (res) {
				let analysis = this.state.analysis;
				let attributeAnalysis = res.attributeAnalysis;
				const twitterHandle = attributeAnalysis.twitter_handle;
				delete attributeAnalysis.twitter_handle;
				analysis[selectedAttribute] = attributeAnalysis;

				let analysisAverages = this.state.analysisAverages;
				analysisAverages[selectedAttribute] = res.analysisMetadata;

				const numberOfHandles = res.analysisMetadata.number_of_handles;

				let analysisDescription = this.state.analysisDescription;
				const description_key = Object.keys(
					analysisAverages[selectedAttribute]
				).find(k => k.includes("description"));
				analysisDescription[selectedAttribute] =
					res.analysisMetadata[description_key];
				delete analysisAverages[selectedAttribute][description_key];
				delete analysisAverages[selectedAttribute].number_of_handles;

				this.setState({
					twitterHandle,
					numberOfHandles,
					analysis,
					analysisAverages,
					analysisDescription,
					isPanelLoading: false
				});
			}
		});
	};

	_formatFetchAttribute = attribute => {
		switch (attribute) {
			case "personality":
				return "personalities";
			case "needs":
				return "needs";
			case "values":
				return "values";
			case "consumption preferences":
				return "consumption_preferences";
			default:
				return null;
		}
	};

	panes = [
		{
			menuItem: "Personality",
			render: () => (
				<Tab.Pane loading={this.state.isPanelLoading}>
					<AnalysisChart
						attribute={"Personality"}
						twitterHandle={this.state.twitterHandle}
						numberOfHandles={this.state.numberOfHandles}
						analysis={this.state.analysis["personality"]}
						description={this.state.analysisDescription["personality"]}
						analysisAverages={this.state.analysisAverages["personality"]}
						redColoring={255}
						greenColoring={0}
						blueColoring={0}
					/>
				</Tab.Pane>
			)
		},
		{
			menuItem: "Needs",
			render: () => (
				<Tab.Pane loading={this.state.isPanelLoading}>
					<AnalysisChart
						attribute={"Needs"}
						twitterHandle={this.state.twitterHandle}
						numberOfHandles={this.state.numberOfHandles}
						analysis={this.state.analysis["needs"]}
						description={this.state.analysisDescription["needs"]}
						analysisAverages={this.state.analysisAverages["needs"]}
						redColoring={0}
						greenColoring={255}
						blueColoring={0}
					/>
				</Tab.Pane>
			)
		},
		{
			menuItem: "Values",
			render: () => (
				<Tab.Pane loading={this.state.isPanelLoading}>
					<AnalysisChart
						attribute={"Values"}
						twitterHandle={this.state.twitterHandle}
						numberOfHandles={this.state.numberOfHandles}
						analysis={this.state.analysis["values"]}
						description={this.state.analysisDescription["values"]}
						analysisAverages={this.state.analysisAverages["values"]}
						redColoring={0}
						greenColoring={0}
						blueColoring={255}
					/>
				</Tab.Pane>
			)
		},
		{
			menuItem: "Consumption Preferences",
			render: () => (
				<Tab.Pane loading={this.state.isPanelLoading}>
					<AnalysisChart
						attribute={"Consumption Preferences"}
						twitterHandle={this.state.twitterHandle}
						numberOfHandles={this.state.numberOfHandles}
						analysis={this.state.analysis["consumption preferences"]}
						description={
							this.state.analysisDescription["consumption preferences"]
						}
						analysisAverages={
							this.state.analysisAverages["consumption preferences"]
						}
						redColoring={128}
						greenColoring={0}
						blueColoring={255}
					/>
				</Tab.Pane>
			)
		}
	];

	render() {
		const { activeIndex } = this.state;
		return (
			<div>
				<Grid columns="equal" style={{ margin: "0em 0em 1em" }}>
					<Grid.Column>
						<Button
							onClick={this.handleBack}
							color="orange"
							style={{ float: "left" }}
						>
							<Icon name="left arrow" />
							Back to search
						</Button>
					</Grid.Column>
					<Grid.Column width={8}>
						<Header as="h1" textAlign="center">
							{this.state.isPanelLoading
								? null
								: `@${this.state.twitterHandle}`}
						</Header>
					</Grid.Column>
					<Grid.Column>
						<Button
							onClick={this.handleBack}
							color="orange"
							style={{ float: "right" }}
						>
							New search
							<Icon name="right arrow" />
						</Button>
					</Grid.Column>
				</Grid>

				<Tab
					panes={this.panes}
					activeIndex={activeIndex}
					onTabChange={this.handleTabChange}
				/>
				<Button
					onClick={() => window.scrollTo(0, 0)}
					style={{ float: "right", margin: "1em 0em" }}
				>
					<Icon name="chevron up" /> Back to top
				</Button>
			</div>
		);
	}
}

export default withRouter(Analysis);
