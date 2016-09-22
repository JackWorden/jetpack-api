Jetpack Agile Flow

Jetpack Agile Flow is a web based Agile issue manager. This is the backend API only. The Ember based front end is found [here](https://github.com/stevenpetryk/jetpack-web).

### Prerequisite requirements
* Ruby (2.3 or higher)
* Bundler
* Postgres (9.5.3)

### Installation

* Set up Postgres users as according to [database.yml](https://github.com/JackWorden/jetpack-api/blob/develop/config/database.yml), or modify `database.yml` to reflect your set up PG users
* Pull down the repository
* Running `bundle install` should install all dependencies


### Starting the server

Jetpack uses Rails' default port `3000`, so running the server with `bundle exec rails s` will start the server on port 3000.

Currently Jetpack does not have any backend workers, so you will not need to start workers. 

### Running tests

Jetpack uses `rspec` as a testing suite. `bundle exec rspec` should run the test suite.


### About
This API provides endpoints for standard CRUD operations for the models used in the application. 

Endpoints and potential responses have been documented via [Paw](https://paw.cloud/). `jetpack-api.paw` is the Pawfile for this project. It contains a list of the endpoints, their responses, and their handled error conditions. 

We authenticate users using Github's OAUTH service. That code is found [here](https://github.com/JackWorden/jetpack-api/blob/develop/app/poros/api/github_authenticator.rb).

Most of the basic CRUD operations are found in the [controllers](https://github.com/JackWorden/jetpack-api/tree/develop/app/controllers). We avoided doing any heavy lifting in the controllers and instead opted to pull that logic into the [POROs (Plain Old Ruby Objects) here](https://github.com/JackWorden/jetpack-api/tree/develop/app/poros/api). 


The relationships are fairly standard and are found in the models directory. [Project](https://github.com/JackWorden/jetpack-api/blob/develop/app/models/project.rb) is the highest level model in the application, with most other models belonging to a Project. 
