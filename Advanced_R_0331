#Advanced R March 31 class 
#Exercise 1
#Load the ggplot2 package
library(ggplot2)

#Load the "mtcars" dataset
data(mtcars)

#Use ggplot() to create a scatter plot of "mpg" vs "hp"
ggplot(mtcars, aes(x = hp, y = mpg)) +
geom_point()

#Customize the plot by adding axis labels and a title
ggplot(mtcars, aes(x = hp, y = mpg)) +
geom_point() +
xlab("Horsepower") +
ylab("Miles per gallon") +
ggtitle("Scatter plot of MPG vs HP")

#Exercise 2 
# Load the ggplot2 package
library(ggplot2)

# Load the "mpg" dataset
data(mpg)

# Use ggplot() to create a bar chart of the average "cty" and "hwy" mileage for each manufacturer
ggplot(mpg, aes(x = manufacturer, y = cty + hwy)) +
  stat_summary(fun = "mean", geom = "bar", fill = "blue") +
  
# Customize the plot by adding axis labels, a title, and changing the color palette
  xlab("Manufacturer") +
  ylab("Average Mileage") +
  ggtitle("Average City and Highway Mileage by Manufacturer") +
  scale_fill_gradient(low = "white", high = "blue")

#Exercise 3 
# Load the plotly package
library(plotly)

# Load the "iris" dataset
data(iris)

# Use plot_ly() to create a scatter plot of "Sepal.Length" vs "Petal.Length"
plot_ly(data = iris, x = ~Petal.Length, y = ~Sepal.Length, 
        type = "scatter", mode = "markers") %>%
  
# Customize the plot by adding axis labels, a title, and enabling hover information
  layout(xaxis = list(title = "Petal Length"),
         yaxis = list(title = "Sepal Length"),
         title = "Scatter plot of Sepal Length vs Petal Length",
         hovermode = "closest")
