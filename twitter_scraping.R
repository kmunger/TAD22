#title: "Intro to rtweet: Collecting Twitter Data"
#author: "Michael W. Kearney"

#This vignette provides a quick tour of the R package `rtweet: 
#Collecting Twitter Data`.

#### Authenticating

#Before we can start collecting Twitter data, we need to create an 
#OAuth token that will allow us to authenticate our connection and 
#access our personal data.

#After the new API changes, getting a new token requires submitting 
#an application for a developer account, which may take a few days. 
#For teaching purposes only, I will temporarily share one of my tokens 
#with each of you, so that we can use the API without having to do the 
#authentication.

#Run the following line
## install rtweet from CRAN
install.packages("rtweet")

## load rtweet package
library(rtweet)

app_name <- "smapp"


tmls$favorite_count

## copy and pasted *your* keys (these are fake)
consumer_key <- "qYQF4B3mp28MAn74iIEc4Og2e"
consumer_secret <- "NW8PATIAzBZt0cAsvm4Ab3vTPDInHMjmbnz2JotisNRLoAXSJR"


access_token <- "89098361-MCBLt2hS68KpEzFUWYuqNi1jBuPrEipWk22rK9yos"
access_secret <- "Tk6k1WGD9ouzZcM4dIhL8q4cdD4Ain1WUD6w3raVEnrtr"

vignette('auth')
## create token

auth <- rtweet_app()

auth



#This function grabs the table of tokens from 
#an annotation object. 

#####################
### Search tweets
#####################

#Search for up to 18,000 (non-retweeted) tweets containing Penn State
## search for 500 tweets 
?search_tweets
rt <- search_tweets(
  "Penn State", n = 500, include_rts = FALSE, token = auth
)

## preview tweets data
rt

## preview users data
users<-users_data(rt)


rt$text[1:25]

#Quickly visualize frequency of tweets over time using 
ts_plot(rt, "hours")

## plot time series of tweets

?ts_plot

ts_plot(rt, "3 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Penn State Twitter statuses",
    subtitle = "Twitter status (tweet) counts aggregated using three-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

#Twitter rate limits cap the number of search results returned to
#18,000 every 15 minutes. To request more than that, simply set
#`retryonratelimit = TRUE` and rtweet will wait for rate limit
#resets for you.


## search for 250,000 tweets containing the word data
#rt <- search_tweets(
# "data", n = 250000, retryonratelimit = TRUE
#)


#Search by geo-location---for example, 
#find 500 tweets in the English
#language sent from the United States.

## search for 500 tweets (in English) sent from the US
rt <- search_tweets(
  "lang:en", geocode = lookup_coords("usa"), n = 500, token = auth
)

#lookup_coords: Get coordinates of specified location.
#Google Maps API key if not 'world' and 'usa'

## create lat/lng variables using all available tweet and profile geo-location data
rt <- lat_lng(rt)

## plot state boundaries
#install.packages("maps")
library(maps)

par(mar = c(0, 0, 0, 0))
maps::map("state", lwd = .25) # U.S. satates


par(mar = c(0, 0, 0, 0))
maps::map("world", lwd = .25) #map of the world

## plot lat and lng points onto state map

par(mar = c(0, 0, 0, 0))
maps::map("state", lwd = .25)
with(rt, points(lng, lat, pch = 20, cex = 1.5, col = rgb(0, .3, .7, .75)))


table(rt$lng)


#####################
### Stream tweets
#####################

#Randomly sample (approximately 1%) from the live stream of 
#all tweets.
## random sample for 30 seconds (default)
rt<- rtweet::stream_tweets(q= "Musk", token=auth, timeout = 3, 
                    file_name = "musk.json")
?stream_tweets


ts_plot(rt, by = "secs")

table(rt$lang)

#Stream all geo enabled tweets from London for 60 seconds.
## stream tweets from london for 60 seconds

rt <- stream_tweets(lookup_coords("london, uk"),  token = auth, timeout = 3)

#Stream all tweets mentioning 
#biden



stream_tweets(
  "joebiden,biden",
  timeout = 60 , #60 seconds
  file_name = "tweetsaboutbiden.json",
  parse = FALSE, token = auth
)


## read in the data as a tidy tbl data frame
biden <- parse_stream("tweetsaboutbiden.json")




#####################
### Get friends
#####################

#Retrieve a list of all the accounts a **user follows**.
## get user IDs of accounts followed by CNN
cnn_fds <- get_friends("cnn", token = auth)

## lookup data on those accounts
cnn_fds_data <- lookup_users(cnn_fds$to_id, token = auth)



#####################
### Get followers
#####################

#Retrieve a list of the **accounts following** a user.

## get user IDs of accounts following CNN
cnn_flw <- get_followers("cnn", n = 750, token = auth)

## lookup data on those accounts
cnn_flw_data <- lookup_users(cnn_flw$from_id, token = auth)


#Or if you really want ALL of their followers:

## how many total follows does cnn have?
cnn <- lookup_users("cnn", token = auth)

cnn$followers_count

## get them all (this would take a little over 10 days)
#cnn_flw <- get_followers(
#  "cnn", n = cnn$followers_count, retryonratelimit = TRUE
#)

#####################
### Get timelines
#####################

#Get the most recent 3,200 tweets 
#from cnn, BBCWorld, and foxnews.

tmls <- get_timelines(c("cnn", "BBCWorld", "foxnews"), n = 3200, token = auth)


#####################
### Get favorites
#####################

#Get the 3 most recently favorited statuses by Taylor Swift
tay <- get_favorites("taylorswift13", n = 3, token = auth)

tay$full_text

#####################
### Search users
#####################

#Search for 10 users with the PSU in their profile bios.

## search for users with PSU in their profiles
usrs <- search_users("PSU", n = 10, token = auth)


colnames(usrs)


#####################
### Get trends
#####################

#Discover what's currently trending in San Francisco.
sf <- get_trends("san francisco", token = auth)
sf$trend
