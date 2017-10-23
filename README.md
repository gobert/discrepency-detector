# Discrepency Detector
[![Travis build information for branch master](https://api.travis-ci.org/gobert/discrepency-detector.svg?branch=master)](https://travis-ci.org/gobert/discrepency-detector)
[![Dependency Status](https://gemnasium.com/gobert/discrepency-detector.svg)](https://gemnasium.com/gobert/discrepency-detector)

[![Security warnings](https://hakiri.io/github/gobert/jeff-money/discrepency-detector.svg)](https://hakiri.io/projects/63f07d45395136)
[![Maintainability](https://api.codeclimate.com/v1/badges/4425814617c25e21de7e/maintainability)](https://codeclimate.com/github/gobert/discrepency-detector/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4425814617c25e21de7e/test_coverage)](https://codeclimate.com/github/gobert/discrepency-detector/test_coverage)

This is an API that check and display the discrepencies between 2 web-services. [Check the original spec](https://github.com/gobert/discrepency-detector/blob/master/SPEC.md).

Usage example:
```sh
curl -vv -H "Accept: application/json" -H "Content-type: application/json" -XPOST http://localhost:3000/ads/status --data '{"ads": [{"external_reference": "1", "status": "active", "description": "foo", "id": 42, "job_id": 2029}]}'
```
Returns
```json
{
  "enabled": [
    {
      "id": "1",
      "ad_server_reference": 42,
      "job_id": 2029,
      "status": "enabled",
      "description": "Description for campaign 11"
    }
  ],
  "deleted": [],
  "disabled": [],
  "discrepencies": [
    {
      "id": "2",
      "ad_server_reference": 44,
      "job_id": 2030,
      "status": "disabled",
      "description": "Description for campaign 12"
    }
  ]
}
```

# Set up
* Install ruby 2.4.2. For instance, using rvm: ```rvm install 2.4.2```
* Install gem bundler: ```gem install bundler --no-ri --no-rdoc```
* Install dependencies: ```bundle install```

# Run it
* Start the webserver: ```bin/rails s```

# Test suite
On top of each commit, all tests must pass:
```
  bundle exec rake
```
# Check code syntax
On top of each commit, no offenses must be detected
```
  bundle exec rubocop -- .
```
