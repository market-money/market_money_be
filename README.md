# Market-Money README
This project is a backend application where it provides functionality for Farmes and Market & Vendors. This project focuses on exposing APIs, using serializers to format JSON responses, testing, error handling, and use of SQL and AR. The testing was completed utilizing Webmock, and happy path and sad path, where applicable, were implemented.

There are 11 endpoints for this application:

Market Endpoints
  - get all markets
  - get one market
  - get all vendors for a market

Vendor Endpoints
  - get one vendor
  - create a vendor
  - update a vendor
  - delete a vendor

MarketVendor Endpoints
  - create a market_vendor
  - delete a market_vendor

AR Endpoint
  - get all markets within a city or state that’s name or description match a string fragment

Consume API Endpoint
  - get cash dispensers (ATMs) close to a market location

# Built with (gems)
- Ruby on Rails
- Pry
- Simplecov
- Rspec-rails
- Faraday
- Faker
- Factory-bot
- Webmock
- JSONAPI-serializer
- Shoulda-matchers

# Getting Started

If you want to checkout the end points using postman, please clone and/or fork this project and follow these steps:
API:
- [TomTom API](https://developer.tomtom.com/), sign up for a key

Set up:
- run bundle
- rails db:{create,migrate}
- Configure credentials (API key obtained above)
- Connect to rails s
- Open postman, input endpoints and appropriate request


*Example*
To get all the list of markets

```json
GET /api/v0/markets
```

expected result, `status:200`
```json
{
       "data": [
           {
               "id": "322458",
               "type": "market",
               "attributes": {
                   "name": "14&U Farmers' Market",
                   "street": "1400 U Street NW ",
                   "city": "Washington",
                   "county": "District of Columbia",
                   "state": "District of Columbia",
                   "zip": "20009",
                   "lat": "38.9169984",
                   "lon": "-77.0320505",
                   "vendor_count": 1
               }
           },
           {
               "id": "322474",
               "type": "market",
               "attributes": {
                   "name": "2nd Street Farmers' Market",
                   "street": "194 second street",
                   "city": "Amherst",
                   "county": "Amherst",
                   "state": "Virginia",
                   "zip": "24521",
                   "lat": "37.583311",
                   "lon": "-79.048573",
                   "vendor_count": 35
               }
           },
           ...,
           ...,
       ]
   }
```

