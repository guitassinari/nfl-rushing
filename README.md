# theScore "the Rush" Interview Challenge
At theScore, we are always looking for intelligent, resourceful, full-stack developers to join our growing team. To help us evaluate new talent, we have created this take-home interview question. This question should take you no more than a few hours.

**All candidates must complete this before the possibility of an in-person interview. During the in-person interview, your submitted project will be used as the base for further extensions.**

## Why a take-home challenge?
In-person coding interviews can be stressful and can hide some people's full potential. A take-home gives you a chance work in a less stressful environment and showcase your talent.

We want you to be at your best and most comfortable.

## A bit about our tech stack
As outlined in our job description, you will come across technologies which include a server-side web framework (like Elixir/Phoenix, Ruby on Rails or a modern Javascript framework) and a front-end Javascript framework (like ReactJS)

## Challenge Background
We have sets of records representing football players' rushing statistics. All records have the following attributes:
* `Player` (Player's name)
* `Team` (Player's team abbreviation)
* `Pos` (Player's postion)
* `Att/G` (Rushing Attempts Per Game Average)
* `Att` (Rushing Attempts)
* `Yds` (Total Rushing Yards)
* `Avg` (Rushing Average Yards Per Attempt)
* `Yds/G` (Rushing Yards Per Game)
* `TD` (Total Rushing Touchdowns)
* `Lng` (Longest Rush -- a `T` represents a touchdown occurred)
* `1st` (Rushing First Downs)
* `1st%` (Rushing First Down Percentage)
* `20+` (Rushing 20+ Yards Each)
* `40+` (Rushing 40+ Yards Each)
* `FUM` (Rushing Fumbles)

In this repo is a sample data file [`rushing.json`](/rushing.json).

### Challenge Requirements
1. Create a web app. This must be able to do the following steps
    1. Create a webpage which displays a table with the contents of [`rushing.json`](/rushing.json)
    2. The user should be able to sort the players by _Total Rushing Yards_, _Longest Rush_ and _Total Rushing Touchdowns_
    3. The user should be able to filter by the player's name
    4. The user should be able to download the sorted data as a CSV, as well as a filtered subset
    
2. The system should be able to potentially support larger sets of data on the order of 10k records.

3. Update the section `Installation and running this solution` in the README file explaining how to run your code

## Submitting a solution
1. Download this repo
2. Complete the problem outlined in the `Requirements` section
3. In your personal public GitHub repo, create a new public repo with this implementation
4. Provide this link to your contact at theScore

We will evaluate you on your ability to solve the problem defined in the requirements section as well as your choice of frameworks, and general coding style.

## Help
If you have any questions regarding requirements, do not hesitate to email your contact at theScore for clarification.

## Installation and running this solution

### General information

This is project was built using Ruby on Rails in the backend with Webpacker + ReactJS + TypeScript for the frontend.

It was built to be run in a Docker environment, but can be also run in your machine directly.

The backend application provides a single endpoint to fetch player rushings data. It allows for pagination, filtering and ordering the returned data. It also allows to export the requested data in CSV format.

The frontend application uses [Ant Design](https://ant.design/) to provide a friendly user interface.

![image](https://user-images.githubusercontent.com/10967861/145908578-c3cb2e6f-8ae4-4a80-b1fd-d17f752ec6c1.png)

### System requirements

In order to run this project you must install the following tools

> Click any of them to see installation instructions

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) >= 3.0.3
- [NodeJS](https://nodejs.org/en/download/package-manager/) >= 14.15.5
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/#mac-stable) >= 1.22.10

This project can be run either in your machine or using Docker. When running in your machine you will need:

- [Postgres](https://www.postgresql.org/download/) >= 13.5

If you're going to run it using Docker you will need:

- [Docker](https://docs.docker.com/get-docker/) >= 20.10.8

### Running the app

Having installed all needed system requirements, its time to prepare your setup.

#### Running directly in your machine

1. Install Ruby gems and JavaScript packages
    ```bash
    bundle install
    yarn install
    ```
2. Create, migrate and seed database
    ```bash
    rails db:create
    rails db:migrate
    ```

3. Import rushings from json
 ```
    docker-compose run web bundle exec rake player_rushing:import["<file_path>"]
 ```
 <details>
  <summary>Example</summary>
  ```
    docker-compose run web bundle exec rake player_rushing:import["rushing.json"]
  ```
</details>

<details>
  <summary>You can also clear all player rushings from database</summary>
  ```
    docker-compose run web bundle exec rake player_rushing:clear
  ```
</details>

4. Start the application and webpack server

    In one terminal run
    ```bash
    DATABASE_HOST=<your_db_host> DATABASE_USERNAME=<your_db_username> DATABASE_PASSWORD=<your_db_password> rails s 
    ```

    In another terminal run
    ```bash
    ./bin/webpack --watch --progress
    ```

5. Access your app

If everything went fine you should be able to see your application running at [localhost:3000](http://localhost:3000).

#### Running with Docker

1. Build the docker images
   ```bash
   docker-compose build
   ```

2. Create and migrate the database
    ```bash
    docker-compose run web bundle exec rails db:create
    docker-compose run web bundle exec rails db:migrate
    ```
3. Import rushings from json
 ```
    bundle exec rake player_rushing:import["<file_path>"]
 ```
 <details>
  <summary>Example</summary>
  ```
    bundle exec rake player_rushing:import["rushing.json"]
  ```
</details>

<details>
  <summary>You can also clear all player rushings from database</summary>
  ```
    bundle exec rake player_rushing:clear
  ```
</details>


4. Run all containers
   ```bash
   docker-compose up
   ```

5. Access your app

If everything went fine you should be able to see your application running at [localhost:3000](http://localhost:3000).

### Running tests

This app uses [Rspec](https://rspec.info/) as testing framework for the backend along with [FactoryBot](https://github.com/thoughtbot/factory_bot) for entities/records creation.

For the frontend we use [Jest](https://jestjs.io/) with [React-Testing-Library](https://testing-library.com/docs/react-testing-library/intro/).

#### Running directly in your machine

#### Backend
1. Create and migrate test database
    ```bash
    rails db:create
    RAILS_ENV=test rails db:migrate
    ```
2. Run the tests
    ```bash
    bundle exec rspec
    ```
#### Frontend
    
    ```
    yarn test
    ```

#### Running in Docker

#### Backend
1. Build images
    ```bash
    docker-compose build
    ```

2. Create and migrate test database
    ```bash
    docker-compose run web bundle exec rails db:create
    docker-compose run -e RAILS_ENV=test web bundle exec rails db:migrate
    ```
3. Run the tests
    ```bash
    docker-compose -e RAILS_ENV=test web bundle exec rspec
    ```

##### Frontend

```
docker-compose run web yarn test
```