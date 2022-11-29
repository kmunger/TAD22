##### R Task


## load rtweet package
library(rtweet)
library(dplyr)
app_name <- "smapp"




## copy and pasted *your* keys (these are fake)
consumer_key <- "qYQF4B3mp28MAn74iIEc4Og2e"
consumer_secret <- "NW8PATIAzBZt0cAsvm4Ab3vTPDInHMjmbnz2JotisNRLoAXSJR"


access_token <- "89098361-MCBLt2hS68KpEzFUWYuqNi1jBuPrEipWk22rK9yos"
access_secret <- "Tk6k1WGD9ouzZcM4dIhL8q4cdD4Ain1WUD6w3raVEnrtr"

vignette('auth')
## create token

auth <- rtweet_app()

auth




## Find the 5 Republican and 5 Democrats in Congress with the most Twitter followers

mcs<-c("@AOC", "@BernieSanders", "@EWarren", "@SpeakerPelosi", "@CoryBooker",
       "@TedCruz", "@RandPaul", "@MarcoRubio", "@dancrenshawtx", "@MittRomney")

mcs_dem<-c("@AOC", "@BernieSanders", "@EWarren", "@SpeakerPelosi", "@CoryBooker")
mcs_rep<-c("@TedCruz", "@RandPaul", "@MarcoRubio", "@dancrenshawtx", "@MittRomney")

## scrape their most recent 200 tweets 

tmls_dem <- get_timelines(mcs_dem, n = 200, token = auth)
tmls_rep <- get_timelines(mcs_rep, n = 200, token = auth)

docs<-data.frame(text = c(paste(tmls_dem$text, collapse = ' ') ,
                 paste(tmls_dem$text, collapse = ' ')),
class = c("D", "R"))
?data.frame

### Create a DFM from the text of these tweets

library(quanteda)
xdfm <-dfm(docs$text, stem = F, remove_punct = T, tolower = T, remove_numbers = TRUE,
           remove = c(stopwords("english"),"¦","€","¥", "¯","~", "http","https","rt", "t.co"))

### Train a naive bayes classifier to predict the label of the tweets (use all the documents)




library(quanteda)
library(quanteda.textmodels)

nb_model <- textmodel_nb(xdfm, docs$class, smooth = 1, prior = "uniform")


### Which terms are most predictive?

posterior <- data.frame(feature = rownames(t(nb_model$param)), 
                        post_D = t(nb_model$param)[,1],
                        post_R = t(nb_model$param)[,2])


head(arrange(posterior, -post_D))
head(arrange(posterior, -post_R), n = 20)
### Now find a political commentator on the left and right (eg Rachel Maddow and Tucker Carlson)


ppl<-c("@TuckerCarlson", "@maddow")


## scrape their most recent 200 tweets 

tmls_ppl <- get_timelines(ppl, n = 200, token = token)


docs_ppl<-aggregate(text ~ user_id, data = tmls_ppl, paste, collapse = " ")


##download their 200 most recent tweets -- use the model to predict whether they are D or R


dfm_ppl <-dfm(docs_ppl$text, stem = F, remove_punct = T, tolower = T, remove_numbers = TRUE, remove = c(stopwords("english"),"¦","€","¥", "¯","~", "http","https","rt", "t.co"))

dfm_ppl <- dfm_match(dfm_ppl, features = featnames(xdfm))


## was it correct?  


predicted_class <- predict(nb_model, newdata = dfm_ppl)


predicted_class
