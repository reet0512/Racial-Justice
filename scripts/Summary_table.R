library("lintr")
library("dplyr")
juvie_arrests <- read.csv("data/Juvenile arrest.csv", stringsAsFactors = FALSE)

# The function takes a data frame as a parameter and return the total number or
# frequency of charges against each race and shows the percentage of charges
# that were treated as a felony for each year from 2013 - 2017

table_summary <- function(dataset) {
  result <- dataset %>%
            mutate(Date = format(as.Date(ARREST_DATE), "%Y")) %>%
            group_by(RACE, Date) %>%
            summarise(Frequency = n(),
            Convicts = sum(CHARGE.TYPE == "FELONY"),
            Felony_Percentage = round(sum(CHARGE.TYPE == "FELONY") /
                                          n() * 100, 2)) %>%
            arrange(-Frequency) %>%
            arrange(Date) %>%
            select(Date, RACE, Frequency, Convicts, Felony_Percentage) %>%
            rename(Race = RACE)
  return(result)
}

aggregate_table <- table_summary(juvie_arrests)

# Few conclusions :-
# 1) Every year the number of charges against black juveniles is maximum,
# followed by white hispanics.
# 2) In 2014, American Indian/ Alaskan Native had the highest felony percentage
# of 50 (2 convicts in 4 charges)

# Save table
write.csv(aggregate_table, "data/Summary_table.csv")
