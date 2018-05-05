import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter as Router } from "react-router-dom";
import App from "./App";
import Navbar from "./components/navbar";
import Footer from "./components/footer";
import "./styles/index.css";

ReactDOM.render(
	<Router>
		<div>
			<Navbar />
			<App />
			<Footer />
		</div>
	</Router>,
	document.getElementById("root")
);
