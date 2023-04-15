library(ggplot2)
data(diamonds)

ggplot(diamonds, aes(x = cut, y = price, fill = color)) + 
  geom_boxplot() +
  xlab("Cut") +
  ylab("Price") +
  ggtitle("Diamond Prices by Cut and Color") +
  scale_fill_brewer(palette = "Set1")

library(plotly)
data(economics)

plot_ly(economics, x = ~date, y = ~psavert, name = "Personal Savings Rate") %>%
  add_lines(y = ~uempmed, name = "Unemployment Rate") %>%
  layout(xaxis = list(title = "Date"), yaxis = list(title = "Percentage"), 
         title = "Personal Savings Rate vs Unemployment Rate Over Time",
         hovermode = "closest",
         legend = list(x = 0.1, y = 0.9))
