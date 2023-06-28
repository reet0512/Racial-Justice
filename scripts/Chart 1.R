library("dplyr")
library("ggplot2")
library("plotly")

library("lintr")

shootings <- read.csv("data/fatal-police-shootings-data.csv",
                      stringsAsFactors = FALSE)

chart_df <- shootings %>%
  filter(race != "") %>%
  group_by(race)

make_chart_1 <- function(dataset) {
  chart <- ggplot(data = dataset) +
    geom_bar(mapping = aes(x = race, fill = threat_level)) +
    labs(title =
           "Frequency of police shootings based on race and individual threat",
         y = "Frequency / Number of Fatalities", x = "Race",
         fill = "Threat Level") +
    scale_x_discrete(labels = c("A" = "Asian", "B" = "Black",
      "H" = "Hispanic", "N" = "Native American", "O" = "Other", "W" = "White"))
  result <- ggplotly(chart)
  return(result)
}

chart_1 <- make_chart_1(shootings)

# Chart shows number of individuals involved in police shootings from 2015-2020
# based on their race. The chart also shows whether the individual was
# aggressive, other or undetermined.

# I chose to have a bar graph for visualization since it is easy to compare
# frequency by length and also the distinction between the threat levels is much
# more easier to interpret.
