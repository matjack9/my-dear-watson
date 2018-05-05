import React from "react";
import { Dimmer, Loader } from "semantic-ui-react";

const Loading = () => (
	<Dimmer active inverted>
		<Loader size="large" inline="centered">
			Loading
		</Loader>
	</Dimmer>
);

export default Loading;
