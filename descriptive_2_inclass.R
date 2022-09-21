# Descriptive practice

#1. Write two sentences. Save each as a seperate object in R. 

require(quanteda)
require(quanteda.textstats)


#2. Combine them into a corpus


txt <- c(sent1 = "This is an example of the summary method for character objects.",
         sent2 = "The cat in the hat swung the bat.")
corpus_txt<-corpus(txt)




#3. Make this corpus into a dfm with all pre-processing options at their defaults.


dfm_txt<-dfm(corpus_txt)


#4. Now save a second dfm, this time with stopwords removed.
dfm_txt2<-dfm_remove(dfm_txt, pattern = stopwords("en") )

#5. Calculate the TTR for each of these dfms (use textstat_lexdiv). Which is higher?
  

textstat_lexdiv(dfm_txt)

textstat_lexdiv(dfm_txt2)




