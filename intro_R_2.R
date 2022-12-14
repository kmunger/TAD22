#title: "R Fundamentals"
#author: "Taken from code prepared by Pablo Barbera, Dan Cervone"

### Using R as a calculator

#The most basic functionality of R is using it as a calculator

10 / 2
sqrt(100) + sqrt(9) 
exp(1) 
2^3 

### Objects and operators

#What makes R very powerful is that you can store results as "objects"
x <- 5
y <- 10

#If you look at the `Environment` panel in your RStudio session, 
#you can see that these numbers are stored in memory.

#Then you can do operations with them, the same way you would do with numbers:

x * y

#You can also save combinations of objects as new objects

z <- x * y

#You can also modify existing objects.

x <- x + 1

#Note that we've used the `<-` sign to assign values to objects. 
#That's the *assignment* operator.
#You can also use `=`, although `<-` is generally preferred. 
#There's a more technical explanation for this preference, 
#but another is that this way you avoid getting confused with `==`, 
#which is used to compare objects:

2 == 2
c(1, 2, 3) == 2

#`==` is a *logical operator*, meaning it outputs `TRUE` or `FALSE`. Other logical operators are:

1 != 2 # not equal to
2 < 2 # less than
2 <= 2 # less than or equal to
2 > 2 # greater than
2 >= 2 # greater than or equal to
(2 < 2) | (2 <= 2) # or
(2 < 2) & (2 <= 2) # and

### Data types

#R has many data types, but the most common ones we'll use are:
  
#1. numeric: `1.1`, `3`, `317`, `Inf`...
#2. logical: `TRUE` or `FALSE`
#3. character: `this is a character`, `hello world!`...
#4. factor: `Democrat`, `Republican`, `Socialist`, ...

#A small trick regarding logical values is that they correspond to `1` and `0`. This will come in hand to count the number of `TRUE` values in a vector.

x <- c(TRUE, TRUE, FALSE)
x * 2
sum(x)

#There are a few special values: `NA`, which denotes a missing value, and `NaN`, 
#which means Not a number. The values `Inf` and `-Inf` are considered numeric. 
#`NULL` denotes a value that is undefined.

0 / 0 # NaN
1 / 0 # Inf
x <- c(1, NA, 0)

#You can find out the data type for each object in `R` using the function `class`, 
#or functions that start with `is.` and then the data type:
  
class("hello world!")
is.numeric("hello world!")
is.character("hello world")
class(c(1, NA, 0))
is.numeric(c(1, NA, 0))

#Probably one of the most useful functions in R is `str`. 
#It displays the internal structure of an object.

str(as.factor(c("Blue", "Blue", "Red")))

#Of course you can always print the object in the console:
  
print(z)

#Note that `print` here is a function: it takes a series of arguments 
#(in this case, the object `z`) and returns a value (`50`).

#This is equivalent to just typing the name of the object in the console. 
#(What's going on behind the scenes is that R is calling the default function to
#print this object; which in this case is just `print`).

z

### Data structures

#Building off of the data types we've learned, *data structures* combine multiple values into a single object. Some common data structures in `R` include:
                                                                            
#1. vectors: sequence of values of a certain type
#2. data frame: a table of vectors, all of the same length
#3. list: collection of objects of different types
                                                                          
#### Vectors

#We've already seen vectors created by **c**ombining multiple values with the `c` command:

student_names <- c("Bill", "Jane", "Sarah", "Fred", "Paul")
math_scores <- c(80, 75, 91, 67, 56)
verbal_scores <- c(72, 90, 99, 60, 68)

#There are shortcuts for creating vectors with certain structures, for instance:

nums1 <- 1:100
nums2 <- seq(-10, 100, by=5) # -10, -5, 0, ..., 100
nums3 <- seq(-10, 100, length.out=467) # 467 equally spaced numbers between -10 and 100

#Notice that we used `seq` to generate both `nums1` and `nums2`. The different behavior is controlled by which arguments (e.g. `by`, `length.out`) are supplied to the function `seq`---we'll discuss this in more detail later.
                                                                          
#With vectors we can carry out some of the most fundamental tasks in data analysis, such as descriptive statistics
                                                                          
mean(math_scores)
min(math_scores - verbal_scores)
summary(verbal_scores)
                                                                          
#and plots.

dev.new(width=10, height=10)
plot(math_scores, verbal_scores)
text(math_scores, verbal_scores, student_names)

#It's easy to pull out specific entries in a vector using `[]`. For example,

math_scores[3]
math_scores[1:3]
math_scores[-(4:5)]
math_scores[which(verbal_scores >= 90)]
math_scores[3] <- 92
math_scores

#### Data frames

#Data frames allow us to combine many vectors of the same length into a single object.

students <- data.frame(student_names, math_scores, verbal_scores)
students
summary(students)

#Notice that `student_names` is a different class (character) than `math_scores` (numeric), yet a data frame combines their values into a single object. We can also create data frames that include new variables:

students <- data.frame(students, final_scores = (math_scores + verbal_scores) / 2)
students

#### Lists

#Lists are an even more flexible way of combining multiple objects into a single object.
#Using lists, we can combine together vectors of different lengths:

list1 <- list(some_numbers = 1:10, some_letters = c("a", "b", "c"))
list1

#or even vectors and data frames, or multiple data frames:

school_info <- list(school_name = "PSU", students = students, 
                    faculty = data.frame(name = c("Kelly Jones", "Matt Smith"), 
                                         age = c(41, 55)))
school_info

