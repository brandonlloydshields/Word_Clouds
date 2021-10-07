
#Install Packages

install.packages("wordcloud2")
library(wordcloud2)

install.packages("wordcloud")
library(wordcloud)

install.packages("RColorBrewer")
library(RColorBrewer)

install.packages("tm")
library(tm)

install.packages"dplyr"
library(dplyr)

install.packages"Rcpp"
library(Rcpp)


#Create a vector only containing text

text.wc <- paste(readLines("modified_txt.txt"))

docs <- Corpus(VectorSource(text.wc))

#Text Cleaning

docs.cleaned <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)

docs.cleaned <- tm_map(docs, content_transformer(tolower))
docs.cleaned <- tm_map(docs, removeWords, stopwords("english"))

#Create a Term Document Matrix
dtm <- TermDocumentMatrix(docs.cleaned) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)


#Remove top 20 rows from Data to eliminate general terms
df.modfified <- df[c(20:nrow(df)),]



#Frequency of onlu 7 or more
df.modified.5 <- df.modfified [c(1:154),]



#Creating the Word Clouds
wordcloud2(data = df.modified.5,
           size = .7,
           minSize = 0,
           color = KSU_palette_repeat_2,
           rotateRatio = .5,
           shuffle = F)

