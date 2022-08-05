#title: "Setting Up R"
#author: "Taken from code prepared by Pablo Barbera, Dan Cervone"
#---
  
#Welcome to the course! 
  
#The goal of this first lesson is to provide an introduction to R for non-programmers.
#We will provide an overview of the fundamentals of this programming language, 
#how to write modular code, and best practices for using R for data analysis.

#__Why R?__ 

#Currently used by most statisticians and social scientists interested in data analysis; 
#and also becoming one of most [popular languages in Data Science]
#Open source: makes it highly customizable and easily extensible through ["packages"](over 7,500 and counting!).
#Powerful tool to generate elegant and effective plots, both with built-in functions and additional packages such as lattice or ggplot2.
#Command-line interface and scripts favors reproducibility.

#We will be using [RStudio](https://www.rstudio.com/) to interact with R

#__RStudio__ is an open-source integrated development environment (IDE). 
#The main advantage of RStudio with respect to other graphical interfaces, 
#such as R GUI (the default), is that it integrates a powerful built-in text editor 
#as well as other tools for plotting, debugging, and workspace management
#Excellent documentation and online help resources.

#example

#You can embed R code in chunks like this one:

1+1 #addition

#You can run each chunk of code one by one, by highlighting the code and clicking 
#`Run` (or pressing `Ctrl + Enter` in Windows or `command + enter` in OS X). 
#You can see the output of the code in the console right below, inside the RStudio window.

#You can also embed plots and graphics, for example:
x <- c(1, 3, 4, 5) #this means you "assign" c(1, 3, 4, 5) to an object called x
y <- c(2, 6, 8, 10)
dev.new(width=10, height=10)
plot(x, y)

#If you run the chunk of code, the plot will be generated on the panel on the bottom right corner. 
