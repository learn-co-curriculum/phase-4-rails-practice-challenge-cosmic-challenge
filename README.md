# Rails Mock Challenge - Cosmic Travel

It is the year 2100 and you run an interplanetary space travel agency. You are building a website to book scientists on missions to other planets.

In this repo, there is a Rails application with some features built out. There
is also a fully built React frontend application, so you can test if your API is
working.

Your job is to build out the Rails API to add the functionality described in the
deliverables below.

## Setup

To download the dependencies for the frontend and backend, run:

```console
$ bundle install
$ npm install --prefix client
```

There is some starter code in the `db/seeds.rb` file so that once you've
generated the models, you'll be able to create data to test your application.

You can run your Rails API on [`localhost:3000`](http://localhost:3000) by running:

```console
$ rails s
```

You can run your React app on [`localhost:4000`](http://localhost:4000) by running:

```console
$ npm start --prefix client
```

You are not being assessed on React, and you don't have to update any of the React
code; the frontend code is available just so that you can test out the behavior
of your API in a realistic setting.

There are also tests included which you can run using `rspec` to check your work.

Depending on your preference, you can either check your progress by:

- Running `rspec` and seeing if your code passes the tests
- Running the React application in the browser and interacting with the API via
  the frontend
- Running the Rails server and using Postman (or equivalent API client) to make requests

## Models

It is your job to build out Planet, Scientist, and Mission models so that scientists can book their missions. **In a given mission, one scientist will visit one planet**. Over their careers, **scientists will visit many planets** and **planets will be visited by many scientists**.

You need to create the following relationships:

- A `Scientist` has many `Missions`, and has many `Planet`s through `Mission`s
- An `Planet` has many `Missions`, and has many `Scientist`s through `Mission`s
- A `Mission` belongs to a `Scientist` and belongs to a `Planet`

Start by creating the models and migrations for the following database tables:

![cosmic_erd](https://curriculum-content.s3.amazonaws.com/phase-4/practice-challenge-cosmic-challenge/cosmic_erd.png)

If you use a Rails generator to create the models, make sure to use the
`--no-test-framework` flag to avoid overwriting the test files.

Add any code needed in the model files to establish the relationships.

Then, run the migrations and seed file:

```console
$ rails db:migrate db:seed
```

> If you aren't able to get the provided seed file working, you are welcome to
> generate your own seed data to test the application.

## Validations

Add validations to the `Scientist` model:

- must have a `name`, and a `field_of_study`
- `name`s must be unique

Add validations to the `Mission` model:

- must have a `name`, a `scientist` and a `planet`
- a `scientist` cannot join the same `mission` twice

## Routes

Set up the following routes. Make sure to return JSON data in the format
specified along with the appropriate HTTP verb.

### GET /scientists

Return JSON data in the format below. **Note**: you should return a JSON
response in this format, without any additional nested data related to each
scientist.

```json
[
  {
    "id": 1,
    "name": "Mel T. Valent",
    "field_of_study": "xenobiology",
    "avatar": "https://robohash.org/mel_t_valent?set=set5"
  },
  {
    "id": 2,
    "name": "P. Legrange",
    "field_of_study": "orbital mechanics",
    "avatar": "https://robohash.org/p_legrange?set=set5"
  }
]
```

### GET /scientists/:id

If the `Scientist` exists, return JSON data in the format below. **Note**: you will
need to serialize the data for this response differently than for the
`GET /scientists` route. Make sure to include an array of missions for each
scientist.

```json
{
  "id": 1,
  "name": "Mel T. Valent",
  "field_of_study": "xenobiology",
  "avatar": "https://robohash.org/mel_t_valent?set=set5",
  "planets": [
    {
      "id": 1,
      "name": "TauCeti E",
      "distance_from_earth": "12 light years",
      "nearest_star": "TauCeti",
      "image": "planet3"
    },
    {
      "id": 2,
      "name": "Maxxor",
      "distance_from_earth": "9 parsecs",
      "nearest_star": "Canus Minor",
      "image": "planet7"
    }
  ]
}
```

If the `Scientist` does not exist, return the following JSON data, along with
the appropriate HTTP status code:

```json
{
  "error": "Scientist not found"
}
```

### POST /scientists

This route should create a new `Scientist`. It should accept an object with the
following properties in the body of the request:

```json
{
  "name": "Evan T'Horizon",
  "field_of_study": "astronavigation",
  "avatar": "https://robohash.org/evan_thorizon?set=set5"
}
```

If the `Scientist` is created successfully, send back a response with the new
`Scientist`:

```json
{
  "id": 3,
  "name": "Evan T'Horizon",
  "field_of_study": "astronavigation",
  "avatar": "https://robohash.org/evan_thorizon?set=set5"
}
```

If the `Scientist` is **not** created successfully, return the following JSON data,
along with the appropriate HTTP status code:

```json
{
  "errors": ["validation errors"]
}
```

### PATCH /scientists/:id

This route should update an existing `Scientist`. It should accept an object with one or more of the
following properties in the body of the request:

```json
{
  "name": "Bevan T'Horizon",
  "field_of_study": "warp drive tech",
  "avatar": "https://robohash.org/bevan_thorizon?set=set5"
}
```

If the `Scientist` is updated successfully, send back a response with the updated
`Scientist` and a 202 `:accepted` status code:

```json
{
  "id": 2,
  "name": "Bevan T'Horizon",
  "field_of_study": "warp drive tech",
  "avatar": "https://robohash.org/bevan_thorizon?set=set5"
}
```

If the `Scientist` is **not** updated successfully, return the following JSON data,
along with the appropriate HTTP status code:

```json
{
  "errors": ["validation errors"]
}
```

OR, given an invalid ID, the appropriate HTTP status code, and the following JSON:

```json
{
  "error": "Scientist not found"
}
```

### DELETE /scientists/:id

If the `Scientist` exists, it should be removed from the database, along with
any `Mission`s that are associated with it (a `Mission` belongs
to an `Scientist`, so you need to delete the `Mission`s before the
`Scientist` can be deleted).

After deleting the `Scientist`, return an _empty_ response body, along with the
appropriate HTTP status code.

If the `Scientist` does not exist, return the following JSON data, along with
the appropriate HTTP status code:

```json
{
  "error": "Scientist not found"
}
```

### GET /planets

Return JSON data in the format below. **Note**: you should return a JSON
response in this format, without any additional nested data related to each
planet.

```json
[
  {
    "id": 1,
    "name": "TauCeti E",
    "distance_from_earth": "12 light years",
    "nearest_star": "TauCeti",
    "image": "planet3"
  },
  {
    "id": 2,
    "name": "Maxxor",
    "distance_from_earth": "9 parsecs",
    "nearest_star": "Canus Minor",
    "image": "planet7"
  }
]
```

### POST /missions

This route should create a new `Missions`. It should accept an object with the
following properties in the body of the request:

```json
{
  "name": "Project Terraform",
  "scientist_id": 1,
  "planet_id": 2
}
```

If the `Mission` is created successfully, send back a response with the `planet` associated with the new `Mission` (contrary to convention, which normally dictates the response would include data about the _mission_ that was created):

```json
{
  "id": 2,
  "name": "Maxxor",
  "distance_from_earth": "9 parsecs",
  "nearest_star": "Canus Minor",
  "image": "planet7"
}
```

If the `Mission` is **not** created successfully, return the following JSON data,
along with the appropriate HTTP status code:

```json
{
  "errors": ["validation errors"]
}
```
