#Import dataset from Github
library (readr)
library(dplyr)

urlfile="https://raw.githubusercontent.com/mokjud/education/main/covid_data_hun.csv"

covid_data_hun<-read_csv(url(urlfile))
View(covid_data_hun)

#1st task

#Find the number of infections today in 2020
infections<-covid_data_hun[covid_data_hun$Datum == '04/03/2020', ]
View(infections)


#2nd task 
summary(covid_data_hun)
#  Max.   :272974

#Task 3

#From Mar 15 to May 15 - find avg

#15/03/2020 - 12
#15/05/2020 - 73

#napi_uj_fertozott - 9

# Rows 12to 73 and column 9
Newlyinf<-covid_data_hun[12:73, 9]
View(Newlyinf)
mean(Newlyinf$napi_uj_fertozott)
#[1] 54.62903

#Mortality rate calculated by 2020 and 2021

# Convert the Datum column to a Date object and extract year
covid_data_hun$Datum <- as.Date(covid_data_hun$Datum, format="%d/%m/%Y")
covid_data_hun$Year <- format(covid_data_hun$Datum, "%Y")

#filter the data for years 2020 and 2021
data_2020_2021 <- covid_data_hun[covid_data_hun$Year %in% c("2020", "2021"),]

#calculate the total number of deaths and infections for each year
total_deaths <- aggregate(data_2020_2021$Elhunyt, by=list(data_2020_2021$Year), sum)
total_infections <- aggregate(data_2020_2021$aktiv_fertozott, by=list(data_2020_2021$Year), sum)

#mortality ratio for each year
mortality_ratio <- total_deaths$x / total_infections$x
print(mortality_ratio)


#Renaming to weekly basis

#extract the week number from the Datum column
covid_data_hun$Week <- as.integer(format(covid_data_hun$Datum, "%U"))

#aggregate the data by week
data_weekly <- aggregate(covid_data_hun[, c("aktiv_fertozott", "Elhunyt", "gyogyul", "osszesen")],
                         by=list(covid_data_hun$Week), sum)

#rename weekly
colnames(data_weekly)[1] <- "Week"
colnames(data_weekly)[2:5] <- paste0(colnames(data_weekly)[2:5], "_weekly")

#save the data as a new file
write.csv(data_weekly, "mynewweekly.csv", row.names=FALSE)
View("mynewweekly.csv")

#Plot
# Extract the day of the week from the Datum column
covid_data_hun$Day <- format(covid_data_hun$Datum, "%A")

# Calculate the average daily infections for each day of the week
avg_infections <- aggregate(covid_data_hun$aktiv_fertozott, by=list(covid_data_hun$Day), mean)

# Create a bar plot of the average daily infections by day of the week
library(ggplot2)
ggplot(avg_infections, aes(x=Group.1, y=x)) + 
  geom_bar(stat="identity", fill="blue") + 
  xlab("Day of the Week") + 
  ylab("Average Daily Infections") + 
  ggtitle("Average Daily Infections by Day of the Week")
#Statistical question

#Is there a statistically significant difference in the average number of daily infections between Mondays and other days of the week?

# Create a subset of the data for Mondays and other days
monday_data <- subset(covid_data_hun, Day == "Monday")
other_data <- subset(covid_data_hun, Day != "Monday")

# Perform a t-test
t.test(monday_data$aktiv_fertozott, other_data$aktiv_fertozott, var.equal = TRUE)

#The p-value of 0.9683 is greater than the commonly used significance level of 0.05, 
#indicating that we fail to reject the null hypothesis that there is no difference in
#daily infections between Mondays and other days of the week.

#install the package
install.packages("praise")
#load the library
library(praise)
#> praise()
#[1] "You are doozie!"
