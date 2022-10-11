
library(jsonlite)
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)



setwd("C:/Users/kevin/Documents/GitHub/TAD22/")

NYTIMES_KEY <- ("A23MR1MrVj8IGJBDQCNYB2m7RNUclkB6")

#NYTIMES_KEY <- ("GmZS4yNWnVdAUqyPcSr3zub25T2h7GoN")


term <- "facebook"
begin_date <- "20200101"
end_date <- "20200401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

str(initialQuery)

xx<-initialQuery[[3]]

xxx<-xx[[1]]

pages_2020 <- vector("list",length=5)

for(i in 0:4){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame() 
  pages_2020[[i+1]] <- nytSearch 
  Sys.sleep(10) #I was getting errors more often when I waited only 1 second between calls. 5 seconds seems to work better.
}
facebook_2020_articles <- rbind_pages(pages_2020)


facebook_2020_articles$response.docs.lead_paragraph[1]


term <- "facebook"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

initialQuery <- fromJSON(baseurl)

pages_2021 <- vector("list",length=5)

for(i in 0:5){
  nytSearch <- fromJSON(paste0(baseurl, "&page=", i), flatten = TRUE) %>% data.frame()
  pages_2021[[i+1]] <- nytSearch
  Sys.sleep(10)
}
facebook_2021_articles <- rbind_pages(pages_2021)

facebook_2021_articles$response.docs.lead_paragraph[1]


table(facebook_2021_articles$response.docs.print_section)




#####in-class practice: 


### save the results of two different queries from the date range  August1 2022 - October 3 2022

term <- "chocolate"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

one <- fromJSON(baseurl)



term <- "vanilla"
begin_date <- "20210101"
end_date <- "20210401"

baseurl <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date,"&end_date=",end_date,
                  "&facet_filter=true&api-key=",NYTIMES_KEY, sep="")

two <- fromJSON(baseurl)


xxone<-one[[3]]

xxxone<-xxone[[1]]



xxtwo<-two[[3]]

xxxtwo<-xxtwo[[1]]





### calculate the proportion of the articles from each search term assigned to a given section name/letter


prop.table(table(xxxone$print_section))

table(xxxone$print_section)/length(xxxone$abstract)


xxxtwo

## create two seperate dfms with the text of the lead paragraphs

library(quanteda.textstats)


## calculate the average Flesch Reading Ease score (hint: use code form descriptive_2.R) for the lead paragraphs from each search term. Which is higher?

mean(textstat_readability(xxxone$lead_paragraph)$Flesch)


mean(textstat_readability(xxxtwo$lead_paragraph)$Flesch)
