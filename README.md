# My Dear Watson

[Live (not yet)](https://google.com)

IBM Watson personality insights from twitter posts rendered through Chart.js data visualization. Ruby on Rails backend and Reactjs frontend.

* [My Dear Watson Backend](https://github.com/matjack9/my-dear-watson/tree/master/my-dear-watson-backend)
* [My Dear Watson Frontend](https://github.com/matjack9/my-dear-watson/tree/master/my-dear-watson-frontend)

![my-dear-watson-screenshot](my-dear-watson-screenshot.png)

## Demo

[![My Dear Watson Demo (not yet)](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)

## How To Use

* Enter a twitter handle to analyze
* Review IBM Watson's scoring of Personality, Needs, Values, and Consumption Preferences for the user
* Compare the results to the averages of previously searched unique twitter handles
* As the database of twitter handles grow, the averages refine

## Tech

* Ruby v5.1.4
* Ruby on Rails v5.1.5
* PostgreSQL 10
* React v16.3.1
* Notable Gems:
  * watson-api-client | handling IBM Watson API calls
  * twitter | handling Twitter API calls
  * figaro | storing API keys
  * (testing frameworks)
* Notable JavaScript Libraries:
  * axios | handling promises
  * react-chartjs-2 | charting analyses
  * uuid | creating unique react keys
  * semantic-ui-react | styling
  * prop-types | confirming react prop types in development
  * jest | unit testing

## Database Relationships

![my-dear-watson-relationships](my-dear-watson-relationships.pdf)

## Prerequisites

* Ruby v5.1.4
* PostgreSQL 10
* React v16.3.1

## Installation

1.  Fork and clone [My Dear Watson](https://github.com/matjack9/my-dear-watson)
2.  Navigate to my-dear-watson-backend, and complete Backend Setup
3.  In a separate terminal window, navigate to my-dear-watson-frontend, and complete Frontend Setup

### Backend Setup

After navigating to my-dear-watson-backend, in the root directory:

1.  Install Gems `bundle install`
2.  Setup Database `rake db:create` then `rake db:migrate`
3.  Start your server `rails s`
    keys...?

### Frontend Setup

After navigating to my-dear-watson-frontend, in the root directory:

1.  Install dependencies `yarn install`
2.  Start your server `yarn start`

### In Your Browser

Navigate to the web address of your Node server, e.g. [http://localhost:3001](http://localhost:3001)

## Tests

TBD

## Credits

* [IBM Watson Personality Insights](https://www.ibm.com/watson/services/personality-insights/)
* [Twitter](https://twitter.com/)

## Future Improvements

* Move away from alert error messages
* Twitter handles saved in the database as same casing on Twitter
* Implement Twitter user profile photos
* Have Chart.js always scale from 0-100
* Ability to compare analyses between two users and not only between a user and averages
