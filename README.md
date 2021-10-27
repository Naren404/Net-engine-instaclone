# NetEngine Ruby on Rails Technical Challenge

## InstaClone

Thanks for your interest in The Scout Talent Group. We are excited that you are interested in joining us as a Ruby on Rails developer.
Congratulations! You have made it to the next round: a coding challenge.

### The Challenge

This challenge involves extending an Instagram clone in Rails. You should add the following feature to the app:

1. Friends
   1. Users should be able to send a friend request to other users
   2. Users should be able to see a list of friend requests
   3. Users should be able to accept or decline friend requests
   4. Users should be able to see a list of any user’s friends

### Pre-requisites

You must have Docker Desktop installed for this to work, as the environment is dockerised.

### How to run this application

1. Once that has completed, type `docker compose run --rm web bundle install -j8`
1. Once that has completed, type `docker compose run --rm web yarn install`
1. Once that has completed, type `docker compose up db -d`
1. Once that has completed, type `docker compose run --rm web bundle exec rails db:setup`
1. In the cloned directory, type `docker compose up -d`
1. In your browser, navigate to `https://localhost:3000`

### Additional information:
1. There is no CSS and JS included currently
1. Frontend using **Haml** or **Erb**, _without_ **css**
1. No limit on gem usage
1. You can access the command line to run ruby code via `docker compose exec web sh`
1. Do **not** spend more than 120 minutes on your implementation. You do not need to complete all the steps. We are evaluating what you can do in this timeframe and the quality of your work, not necessarily the quantity of code.
   We are looking for well structured and written code, following current Rails best practices. We will not evaluate your view logic. Testing is not a necessity, but will score you bonus points.
   Submission
   
#### Submission
Either
1. Add the project as a public repository on your GitHub account, or
1. Package up your code in a zip file

Please supply a link or the zip file the ben@netengine.com.au
