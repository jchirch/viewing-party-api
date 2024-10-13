# Viewing Part API - Solo Project

This is the base repo for the Viewing Party Solo Project for Module 3 in Turing's Software Engineering Program. 

## About this Application

Viewing Party is an application that allows users to explore movies and create a Viewing Party Event that invites users and keeps track of a host. Once completed, this application will collect relevant information about movies from an external API, provide CRUD functionality for creating a Viewing Party and restrict its use to only verified users. 

## Setup

1. Fork and clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,migrate,seed}`

Spend some time familiarizing yourself with the functionality and structure of the application so far.

Run the application and test out some endpoints: `rails s`

https://calm-dawn-75890-e1bce695920b.herokuapp.com/ | https://git.heroku.com/calm-dawn-75890.git

should i take my controller methods, turn them into gateway class methods, and call them in my index?
refactor routes, all tests, etc?
test that the gateway class method works in the gateway_spec and then test that the request works using the gateway class method in the request spec? what does in the model class/spec besides validations?

is git push heroku main deploying the app?

compare top_20 to movie_search

3rd endpoint, re do serializer? new serializer? PORO?