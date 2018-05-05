import axios from "axios";

const API_ROOT = "http://localhost:3000/api/v1";
const API_VER = 1;

axios.defaults.baseURL = API_ROOT;

function handleErrors(error) {
	if (error.response) {
		// The request was made and the server responded with a status code
		// that falls out of the range of 2xx
		alert(error.response.data.errors);
		// console.log(error.response.status);
		// console.log(error.response.headers);
	} else if (error.request) {
		// The request was made but no response was received
		// `error.request` is an instance of XMLHttpRequest in the browser and an instance of
		// http.ClientRequest in node.js
		//
		// console.log(error.request);
	} else {
		// Something happened in setting up the request that triggered an Error
		//
		// console.log("Error", error.message);
	}
	// console.log(error.config);
}

export function fetchTwitterAccounts() {
	return axios.get("/twitter_accounts").catch(handleErrors);
}

export function postTwitterAccount(handle) {
	return axios.post("/twitter_accounts", { handle }).catch(handleErrors);
}

/*
	For below, "attribute" arguments must be one of:
		-"personalities"
		-"needs"
		-"values"
		-"consumption_preferences"
*/

export function fetchAccountAttribute(id, attribute) {
	return axios
		.get("/twitter_accounts/" + id + "/" + attribute)
		.catch(handleErrors);
}

export function fetchAllAttribute(attribute) {
	return axios.get("/" + attribute).catch(handleErrors);
}

export function fetchMetadata(attribute) {
	return axios
		.get("/analysis_metadata/" + API_VER + "/" + attribute)
		.catch(handleErrors);
}

export function fetchAccountAttributeAndMetadata(id, attribute) {
	let finalRes = {};
	return fetchAccountAttribute(id, attribute)
		.then(res => {
			finalRes.attributeAnalysis = res.data;
		})
		.then(() =>
			fetchMetadata(attribute).then(
				res => (finalRes.analysisMetadata = res.data)
			)
		)
		.then(() => finalRes);
}
