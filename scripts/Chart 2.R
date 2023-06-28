library(dplyr)
library(ggplot2)
library(lintr)

# The information in chart 2 is gathered in compas data.
# Chart 2 takes a compas dataset as parameter and
# shows the decile scores by the number of people falls in that decile
# colored by different races.

# 1. This chart shows that scores for Caucasian defendants were skewed toward
# lower-risk categories, while African-American defendants were evenly
# distributed across scores. Notice that all the defendants in this chart are
# those who had not been arrested for a new offense or who had recidivated
# within two years.

# 2. This chart also shows for the defendants who had not recidivated within two
# years, the number of African-American defendants who were categorized as the
# highest-risk(decile score is 10) is about the same as the number of Caucasian
# defendants who were categorized as the medium-risk(about score 5), or the same
# as the number of Hispanic or other races defendants who were categorized as
# the lowest-risk(about score 2.5). Notice that the number is the same but how
# the campas scores of recidivism are different.

draw_chart_2 <- function(compas) {
  compas_not_re <- compas %>%
    filter(is_recid == 0, decile_score >= 1) %>%
    group_by(race, decile_score) %>%
    summarize(count = n())

  # This encoding type will show the differences between each races by `color`,
  # and the how they are different by `position`

  ggplot(data = compas_not_re) +
    geom_smooth(mapping = aes(x = decile_score, y = count, color = race)) +
    labs(title = "Comparison of COMPAS scores between two races",
         x = "COMPAS scores",
         y = "The number of the defendants"
        )
}

# inlcude the chart_2 in index.rmd to draw the chart or simply call the method
# draw_chart_2(compas) will do the same thing( This plot has warning messages  )
compas <- read.csv("data/compas-scores.csv", stringsAsFactors = FALSE)
chart_2 <- draw_chart_2(compas)
