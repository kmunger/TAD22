
# Set up workspace
rm(list = ls())

setwd("C:/Users/kevin/Documents/GitHub/TAD22/")

# Loading packages
#install.packages("factoextra")

library(quanteda)
library(factoextra)
library(dplyr)

## 1 PCA

# 1.1  function in base R for PCA:
# see: http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/118-principal-component-analysis-in-r-prcomp-vs-princomp/
?prcomp # uses the singular value decomposition approach: examines the covariances/correlations between individuals

# Remember to center your data! (default = TRUE) -- use scale() on your matrix beforehand, or the option in prcomp()
# And don't have any missing values!



# 1.2 Example
data("data_corpus_inaugural")
inaugural <- corpus_subset(data_corpus_inaugural, Year > "1900-01-01")

inaugural_dfm <- dfm_wordstem(
                dfm_remove(
                dfm(tokens(inaugural), 
                remove_punct = T ),
                stopwords("english")
))


inaugural_mat <- convert(inaugural_dfm, to = "matrix") # convert to matrix

# run pca
inaugural_pca <- prcomp(inaugural_mat, center = TRUE, scale = TRUE)

# visualize eigenvalues (scree plot: shows percentage of variance explained by each dimension)
fviz_eig(inaugural_pca, addlabels = TRUE)

# Loadings for each variable: columns contain the eigenvectors
inaugural_pca$rotation[1:10, 1:5]
dim(inaugural_pca$rotation)

# Q: can we interpret the dimensions?
# top loadings on PC1
pc_loadings <- inaugural_pca$rotation

# what do we expect this correlation to be?
cor(pc_loadings[,1], pc_loadings[,2])  # these should be orthogonal

# token loadings
N <- 10
pc1_loading <- tibble(token = rownames(pc_loadings), loading = as.vector(pc_loadings[,1])) %>% arrange(-loading)
pc1_loading$loading <- scale(pc1_loading$loading, center = TRUE)
pc1_loading <- rbind(top_n(pc1_loading, N, loading),top_n(pc1_loading, -N, loading))
pc1_loading <- transform(pc1_loading, token = factor(token, levels = unique(token)))

# plot top tokens according to absolute loading values
library(ggplot2)
ggplot(pc1_loading, aes(token, loading)) + 
  geom_bar(stat = "identity", fill = ifelse(pc1_loading$loading <= 0, "grey20", "grey70")) +
  coord_flip() + 
  xlab("Tokens") + ylab("Tokens with Top Loadings on PC1") +
  scale_colour_grey(start = .3, end = .7) +
  theme(panel.background = element_blank(),
        axis.text.x = element_text(size=16),
        axis.text.y = element_text(size=16),
        axis.title.y = element_text(size=18),
        axis.title.x = element_text(size=18),
        legend.text=element_text(size=16),
        legend.title=element_blank(),
        legend.key=element_blank(),
        legend.position = "top",
        legend.spacing.x = unit(0.25, 'cm'),
        plot.margin=unit(c(1,1,0,0),"cm"))

# Value of the rotated data: your "new", dimensionality reduced data
View(inaugural_pca$x)  # each observation 



#####Problem: major dimension is time


###In-class assignment:


### re-run the PCA using only the inaugural addresses from 
### after WWII


### Plot the scree plot -- how many dimensions are in this 
### smaller dataset?






