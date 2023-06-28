library(dplyr)
library(ggplot2)
library(lintr)

# The information in chart 3 is gathered in compas data.
# Chart 3 takes a Compas dataset as parameter and
# shows if the race will be a factor that influences the COMPAS score.
# When the number on the y axis is higher than 0, it means being this
# particular race will have more chance of being categorized as high-supervision
# (scored as medium or high, or >= 5), and vice versa.

# 1. This chart shows that when other variables like age or sex are controlled
# as the same, the race will be a factor for COMPAS scoring, and the difference
# for each races is significant.
# 2. From this chart, being an African-American will have the highest chance of
# being scored as high-risk while being Hispanic(apart from the
# category "Other") will have the lowest.

get_single_race_rate <- function(object_race, compas_df) {
  result <- compas_df[compas_df$race == object_race,
                                    "chance_sum"]$chance_sum
  other_races <- sum(compas_df[compas_df$race != object_race,
                           "chance_sum"]$chance_sum) / 5
  result <- (result - other_races) / 6
  return(result)
}

draw_chart_3 <- function(compas, race_filter) {
  compas_rate_df <- compas %>%
    filter(decile_score >= 1) %>%
    mutate(score_type = (decile_score >= 5), count_per = 1) %>%
    group_by(age_cat, sex, race) %>%
    summarize(count = sum(count_per), chance =
                sum(count_per[score_type == TRUE]) / sum(count_per)) %>%
    group_by(race) %>%
    summarize(chance_sum = sum(chance))

  races_rate_data <- as.data.frame(
    sapply(t(compas_rate_df[, "race"]), get_single_race_rate, compas_rate_df))

  # This encoding type will show if the race will be a factor and how the factor
  # influences the outcome by `position`, and `direction`
  races_rate_data <- races_rate_data %>%
    mutate(
      race = row.names(races_rate_data),
      chances =
    `sapply(t(compas_rate_df[, "race"]), get_single_race_rate, compas_rate_df)`)

  races_rate_data <- races_rate_data %>%
    filter(race %in% race_filter)

  chart3_plot <- ggplot(data = races_rate_data) +
    geom_point(mapping = aes(x = race,
      y = chances)) +
  labs(title =
           "Race influce on COMPAS score with all other factors staying the same",
       x = "Race",
       y = "Chance of being categorized as high risk"
           ) +
    geom_hline(yintercept = 0, color = "red")
  chart3_plot <- ggplotly(chart3_plot)
  chart3_plot <- chart3_plot %>%
    layout(xaxis = list(tittle = "Race"))
  return(chart3_plot)
}

# inlcude the chart_3 in index.rmd to draw the chart or simply call the method
# draw_chart_3(compas) will do the same thing.
compas <- read.csv("./data/compas-scores.csv", stringsAsFactors = FALSE)
