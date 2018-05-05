import React, { Component } from "react";
import { Radar } from "react-chartjs-2";
import PropTypes from "prop-types";
import uuid from "uuid";
import { Table, Header, Message, Icon } from "semantic-ui-react";

class AnalysisChart extends Component {
	buildLabels = analysis => {
		return Object.keys(this._serializeAnalysis(analysis)).map(
			attribute =>
				attribute.includes("_")
					? attribute
							.split("_")
							.map(str => str.slice(0, 1).toUpperCase() + str.slice(1))
							.join(" ")
					: attribute.slice(0, 1).toUpperCase() + attribute.slice(1)
		);
	};

	buildData = analysis => Object.values(this._serializeAnalysis(analysis));

	chartData = () => ({
		labels: this.buildLabels(this.props.analysis),
		datasets: [
			{
				label: `${this.props.twitterHandle}`,
				borderColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				backgroundColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				borderWidth: 2,
				pointBackgroundColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				pointBorderColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				pointBorderWidth: 1,
				pointRadius: 8,
				pointHoverBackgroundColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				pointHoverBorderColor: `rgba(${this.props.redColoring}, ${
					this.props.greenColoring
				}, ${this.props.blueColoring}, 0.2)`,
				data: this.buildData(this.props.analysis)
			},
			{
				label: "My Dear Watson Averages",
				borderColor: "rgba(128, 128, 128, 0.2)",
				backgroundColor: "rgba(128, 128, 128, 0.2)",
				borderWidth: 2,
				pointBackgroundColor: "rgba(128, 128, 128, 0.2)",
				pointBorderColor: "rgba(128, 128, 128, 0.2)",
				pointBorderWidth: 1,
				pointRadius: 8,
				pointHoverBackgroundColor: "rgba(128, 128, 128, 0.2)",
				pointHoverBorderColor: "rgba(128, 128, 128, 0.2)",
				data: this.buildData(this.props.analysisAverages)
			}
		]
	});

	_serializeAnalysis = analysis => {
		delete analysis.id;
		delete analysis.twitter_account_id;
		delete analysis.created_at;
		delete analysis.updated_at;
		return analysis;
	};

	render() {
		let tableRows = [];
		let descriptionLabels = Object.keys(this.props.description);
		descriptionLabels.sort((a, b) => {
			let textA = a.toUpperCase();
			let textB = b.toUpperCase();

			return textA.localeCompare(textB);
		});

		for (const label of descriptionLabels) {
			tableRows.push(
				<Table.Row key={uuid()}>
					<Table.Cell key={uuid()}>{label}</Table.Cell>
					<Table.Cell key={uuid()}>{this.props.description[label]}</Table.Cell>
				</Table.Row>
			);
		}

		return (
			<div>
				<div style={{ margin: "1em 0em 4em" }}>
					<Radar data={this.chartData} />
					<Message compact attached="bottom" style={{ margin: "2em 0em 0em" }}>
						My Dear Watson Averages is currently based on{" "}
						{this.props.numberOfHandles.toLocaleString()} previously searched
						unique twitter handles. As the pool grows, the averages refine.
					</Message>
				</div>

				<Header as="h3" textAlign="center">
					Understanding IBM Wastson Personality Insights
				</Header>
				<Table celled padded>
					<Table.Header>
						<Table.Row>
							<Table.HeaderCell singleLine>
								{this.props.attribute === "Consumption Preferences"
									? "Scoring"
									: this.props.attribute}
							</Table.HeaderCell>
							<Table.HeaderCell>
								{this.props.attribute === "Consumption Preferences"
									? "Description"
									: "Individuals who score high..."}
							</Table.HeaderCell>
						</Table.Row>
					</Table.Header>
					<Table.Body>{tableRows}</Table.Body>
				</Table>
				<Message attached="bottom">
					<Icon name="external" />
					<a
						target="_blank"
						rel="noopener noreferrer"
						href="https://console.bluemix.net/docs/services/personality-insights/numeric.html#numeric"
					>
						Learn more about the scoring from IBM Watson.
					</a>
				</Message>
			</div>
		);
	}
}

AnalysisChart.propTypes = {
	attribute: PropTypes.string.isRequired,
	twitterHandle: PropTypes.string,
	numberOfHandles: PropTypes.number,
	analysis: PropTypes.object,
	description: PropTypes.object,
	analysisAverages: PropTypes.object,
	redColoring: PropTypes.number.isRequired,
	greenColoring: PropTypes.number.isRequired,
	blueColoring: PropTypes.number.isRequired
};

export default AnalysisChart;
