# Talent Buyer API

[![Build Status](https://travis-ci.com/colinwarmstrong/quantified_self.svg?branch=master)](https://travis-ci.com/colinwarmstrong/quantified_self) [![Coverage Status](https://coveralls.io/repos/github/colinwarmstrong/talent-buyer-api/badge.svg?branch=master)](https://coveralls.io/github/colinwarmstrong/talent-buyer-api?branch=master)

Talent Buyer API is RESTful JSON API built to serve as the backend for [Talent Buyer](https://github.com/GraySmith00/talent-buyer-client): a tool for music talent buyers to forecast concerts, organize offers, review riders, and settle financials.

This project was built as part the backend curriculum at Turing School of Software and Design.  The project spec can be found [here](http://frontend.turing.io/projects/capstone.html).


## Getting Started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

This repository uses [Devise::JWT](https://github.com/waiting-for-dev/devise-jwt) for authentication.  The authentication process relies on a secret key environment variable for token encryption and decryption.  The process for generating and using this secret key is outlined below in __Installation and Setup__.

### Installation and Setup

From your terminal, clone the repository to your local machine:

```
git clone https://github.com/colinwarmstrong/talent-buyer-api.git
```

Change into the directory:

```
cd talent-buyer-api
```

Install and update gems:

```
bundle install
bundle update
```

Setup the database:

```
rake db:{create,migrate,seed}
```

Next, use [Figaro](https://github.com/laserlemon/figaro) to generate an `application.yml` file in `/config`:

```
bundle exec figaro install
```

Now use Rails to generate a unique secret key:

```
rails secret
```

Next, put this line into `/config/application.yml`, replacing `<SECRET_KEY>` with the secret key you just generated:

```
DEVISE_JWT_SECRET_KEY: <SECRET_KEY>
```

The repository is now configured to run your local machine.  To spin up a server, run the following:

```
rails s
```

Once the server is up and running, visit [http://localhost:5000](http://localhost:5000) or any of the other endpoints to see the JSON that is returned.


## Running the tests

The test suite is built using RSpec.  After setting up the respository locally, run the following command to run the test suite:
```
bundle exec rspec
```

## Endpoints

All endpoints can be accessed by appending them to the root URL `https://talent-buyer-api.herokuapp.com`

##### Authentication Endpoints
- `POST /signup`
	```
    Expected request body:
    
  	{
      buyer: {
        email: 'buyer@example.com',
        password: 'password',
        first_name: 'Billy',
        last_name: 'Mays'
      }
    }
    ```
	- Route for registering a user
    
- `POST  /login`
	```
    Expected request body:
    
	{
      buyer: {
        email: buyer.email,
        password: buyer.password
      }
    }
    ```
    - Route for logging in

- `DELETE /logout`
	- Route for logging out

##### Buyer Endpoints
- `GET /api/v1/buyers/:buyer_id/venues` 
	- Returns information about all venues associated with a specific buyer:
	```
	[{:id=>1, 
      :name=>"ol saloon",
      :street_address=>"123 Swan Street",
      :city=>"Panama City", :state=>"Kansas",
      :zip=>12345,
      :capacity=>47,
      :venue_songkick_id=>47},
 	 {:id=>2,
      :name=>"Fillmmore",
      :street_address=>"123 Swan Street",
      :city=>"Panama City",
      :state=>"Kansas",
      :zip=>12345,
      :capacity=>47,
      :venue_songkick_id=>12}]
   ```
- `GET /api/v1/buyers/:buyer_id/offers`
	- Returns information about all offers associated with a specific buyer:
	```
    [{:id=>1,
  	  :venue_id=>1,
  	  :artist_id=>1,
  	  :buyer_id=>1,
  	  :guarantee=>9001,
  	  :bonuses=>"Free chips in the dressing room",
  	  :radius_clause=>"100 miles, 60 +/- days",
  	  :total_expenses=>5000,
  	  :gross_potential=>4001,
  	  :door_times=>"9pm - 11pm",
  	  :age_range=>"18+",
  	  :merch_split=>"80/20 band/venue",
  	  :date=>"2018-12-24",
  	  :status=>"pending",
  	  :artist_name=>"Sepultura"},
	 {:id=>2,
  	  :venue_id=>1,
  	  :artist_id=>1,
  	  :buyer_id=>1,
  	  :guarantee=>9001,
  	  :bonuses=>"Free chips in the dressing room",
  	  :radius_clause=>"100 miles, 60 +/- days",
  	  :total_expenses=>5000,
  	  :gross_potential=>4001,
  	  :door_times=>"9pm - 11pm",
  	  :age_range=>"18+",
  	  :merch_split=>"80/20 band/venue",
  	  :date=>"2018-12-24",
  	  :status=>"pending",
  	  :artist_name=>"Sepultura"}]
    ```
- `PUT /api/v1/buyers/:buyer_id/offers/:offer_id`
	```
    {
    	"message": "Successfully removed {FOODNAME} from {MEALNAME}"
	}
    ```
    - Route for updating an existing offer:

##### Favorites Endpoints
- GET [/api/v1/favorite_foods](https://quantifiedself1.herokuapp.com/api/v1/favorite_foods)
	- Returns information about foods that are eaten most frequently in the following format:
	```
	[
      {
        "timesEaten": 4,
        "foods":
          [
            {
              "name": "Banana",
              "calories": 200,
              "mealsWhenEaten": ["Breakfast", "Dinner"]
            },
      },
      "timesEaten": 3,
      "foods":
        [
          {
            "name": "Strawberries",
            "calories": 200,
            "mealsWhenEaten": ["Breakfast", "Lunch", "Dinner"]
          },
          {
            "name": "Almonds"
            "calories": 800,
            "mealsWhenEaten": ["Snacks"]
          }
        ]
      }
  ]
	```

## Deployment

Talent Buyer API is deployed through [Heroku](https://www.heroku.com/) and hosted at [https://talent-buyer-api.herokuapp.com/](https://talent-buyer-api.herokuapp.com/).

## Built With

* [Rails 5.2.1](https://rubyonrails.org/) - Ruby based web framework
* [Postgres 1.1.3](https://www.postgresql.org/) - Relational SQL Database

## Authors

* **Colin Armstrong**  
 	- [GitHub](https://github.com/colinwarmstrong)
 	- [LinkedIn](https://www.linkedin.com/in/colinwarmstrong/)

* **Tristan Bambauer**  
 	- [GitHub](https://github.com/TristanB17)
 	- [LinkedIn](https://www.linkedin.com/in/tristan-bambauer/)

* **Tim Fischer**  
 	- [GitHub](https://github.com/TFisch)
 	- [LinkedIn](https://www.linkedin.com/in/timrfischer/)

* **Gray Smith**  
 	- [GitHub](https://github.com/GraySmith00)
 	- [LinkedIn](https://www.linkedin.com/in/graysmith00/)


## Contributing

If you would like to contribute, feel free to reach out to any of the authors via email or LinkedIn.
