# Manupulating text in R

#1. Find a sentence online. Save it as a string. 

require(quanteda)

stringz <- "Help people interested in this repository understand your project by adding a README."


#2. Select only the third word of the sentence. Save it as a new string.

third_word <- substr(stringz, 13, 22)

third_word_alt<-unlist(strsplit(stringz, split = " "))[3]

#3. Choose a letter that appears in your sentence. Use the gsub command to replace all instances of that letter with a period. 

gsub(x = stringz, pattern = 'o', replacement = ".")

