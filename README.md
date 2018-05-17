# My Dear Watson

[Live!](https://matjack9.github.io/my-dear-watson-frontend/)

IBM Watson personality insights from Twitter posts rendered through Chart.js data visualization. Ruby on Rails backend and React frontend.

* [My Dear Watson Backend](https://github.com/matjack9/my-dear-watson-backend)
* [My Dear Watson Frontend](https://github.com/matjack9/my-dear-watson-frontend)

![my-dear-watson-screenshot](https://github.com/matjack9/my-dear-watson/blob/master/my-dear-watson-screenshot.png)

## Demo

[![My Dear Watson Demo](http://img.youtube.com/vi/GuJkazq79xg/0.jpg)](https://youtu.be/GuJkazq79xg)

## How To Use

* Enter a Twitter handle to analyze
* Review IBM Watson's scoring of Personality, Needs, Values, and Consumption Preferences for the user
* Compare the results to the averages of previously searched unique twitter handles
* As the database of Twitter handles grow, the averages refine

## Tech

* Ruby v5.1.4
* Ruby on Rails v5.1.5
* PostgreSQL 10
* React v16.3.1
* Notable Ruby Gems:
  * watson-api-client: handling IBM Watson API calls
  * twitter: handling Twitter API calls
  * figaro: storing secure keys
* Notable JavaScript Libraries:
  * axios: handling promises
  * react-chartjs-2: charting analyses
  * uuid: creating unique React keys
  * semantic-ui-react: styling
  * prop-types: testing React prop types

## Domain Model

![my-dear-watson-relationships](https://github.com/matjack9/my-dear-watson/blob/master/my-dear-watson-relationships.png)

## Code

IBM Watson Personality Insights returns a large amount of data with each API call making backend organization critical. The code snippets below show some methods used to optimally persist and render data for the frontend.

### Cached Averages

The backend API renders not only the analysis of one Twitter handle, but also the averages of all Twitter handles in the database. In order to minimize database queries, there is an analysis_metadata table storing the analysis averages. Each time an analysis saves to the database, a callback updates the analysis_metadata averages thereby caching the average scores. A request can simply query the averages on this table as opposed to demanding ActiveRecord calculate them all in that instant.

`app/models/value.rb`

```Ruby
class Value < ApplicationRecord
  belongs_to :twitter_account

  after_save :update_analysis_metadata
  # each save updates the averages persisted on analysis_metadata

  def self.averages
    self.select('
      count(id) as number_of_handles,
      avg(conservation) as conservation,
      avg(openness_to_change) as openness_to_change,
      avg(hedonism) as hedonism,
      avg(self_enhancement) as self_enhancement,
      avg(self_transcendence) as self_transcendence
      ')
  end

  def twitter_handle
    self.twitter_account.handle
  end

  private

  def update_analysis_metadata
    average_ratings = Value.averages[0].as_json.except("id")
    AnalysisMetadatum.find_by!(api_version: 1).update(average_ratings)
  end
end
```

### Dynamic Frontend Rendering

With all four analysis types each rendering on a Chart.js radar chart, the Analysis container passes all of the score types as props to one abstract chart component `src/components/analysisChart.js`. The abstract code is more effective and easier to maintain while still preserving readability.

`src/containers/analysis.js`

```JavaScript
panes = [
  ...
  ,
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
        {/* each pane receives its respective analysis data and distinct styling as props from the container */}
      </Tab.Pane>
    )
  },
  ...
]
```

### PropTypes

PropTypes serve as simple type testing for props being passed into React components.

`src/components/analysisChart.js`

```JavaScript
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
```

## Prerequisites

* Ruby v5.1.4
* PostgreSQL 10
* React v16.3.1

## Installation

1.  Clone [My Dear Watson](https://github.com/matjack9/my-dear-watson)
2.  Navigate to `/my-dear-watson-backend`, and complete Backend Setup
3.  In a separate terminal window, navigate to `/my-dear-watson-frontend`, and complete Frontend Setup

### Backend Setup

After navigating to `/my-dear-watson-backend`:

1.  Install gems `bundle install`
2.  Request API keys from [IBM Watson](https://console.bluemix.net/registration/?target=%2Fdeveloper%2Fwatson%2Fcreate-project%3Fservices%3Dpersonality_insights%26hideTours%3Dtrue&cm_mmc%3DOSocial_Tumblr-_-Watson%2BCore_Watson%2BCore%2B-%2BPlatform-_-WW_WW-_-wdc-ref%26cm_mmc%3DOSocial_Tumblr-_-Watson%2BCore_Watson%2BCore%2B-%2BPlatform-_-WW_WW-_-wdc-ref%26cm_mmca1%3D000000OF%26cm_mmca2%3D10000409)
3.  Request API keys from [Twitter](https://developer.twitter.com/)
4.  Store the relevant keys in:

* `/app/controllers/api/v1/watson_api_controller.rb`
* `/app/controllers/api/v1/twitter_api_controller.rb`

5.  Setup database `rake db:create` then `rake db:migrate`
6.  Seed database `rake db:seed`
7.  Start your server `rails s`

### Frontend Setup

After navigating to `/my-dear-watson-frontend`:

1.  Install dependencies `yarn install`
2.  Start your server `yarn start`

### In Your Browser

Navigate to the web address of your Node server, e.g. [http://localhost:3001](http://localhost:3001)

## Future Improvements

* Move away from alert error messages
* Save Twitter handles in the database in same casing as on Twitter
* Implement Twitter profile photos
* Have charts always scale 0-100
* Develop ability to compare analyses between two twitter handles directly

## Credits

* [IBM Watson Personality Insights](https://www.ibm.com/watson/services/personality-insights/)
* [Twitter](https://twitter.com/)

MIT © [Matt Jackson](https://www.linkedin.com/in/matjack/)
