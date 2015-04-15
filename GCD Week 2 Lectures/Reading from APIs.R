## Accessing Twitter from R

myapp <- oauth_app("twitter",
                   key="yourConsumerKeyHere",
                   secret="yourConsumerSecretHere")
sig <- sign_oauth1.0(myapp,
                     token="yourTokenHere",
                     token_secret="yourTokenSecretHere")
homeTL <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

## Converting the json object

library(jsonlite)
json1 <- content(homeTL)
json2 <- jsonlite::fromJSON(toJSON(json1))
json2[1:10, 1:4]

