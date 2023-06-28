library(dplyr)

shootings <- read.csv("data/fatal-police-shootings-data.csv",
                      stringsAsFactors = FALSE)
inmates <- read.csv("data/compas-scores-raw.csv", stringsAsFactors = FALSE)
arrests <- read.csv("data/Juvenile arrest.csv", stringsAsFactors = FALSE)
labour <- read.csv(
  "data/Labor_Force_Status_by_Race_and_Ethnicity__Beginning_2012.csv",
  stringsAsFactors = FALSE)


shootings_by_race <- group_by(shootings, race) %>%
  summarise(
    count = n()
  )

armed_or_not <- group_by(shootings, armed) %>%
  summarise(
    armed_with = n()
  ) %>%
  arrange(-armed_with)

inmates_by_race <- group_by(inmates, Ethnic_Code_Text) %>%
  summarise(
    inmates = n()
  )

most_inmates <- inmates_by_race %>%
  filter(inmates == max(inmates)) %>%
  pull(Ethnic_Code_Text)

inmate_risk <- group_by(inmates, RecSupervisionLevelText) %>%
  summarise(
    risk = n(),
    white = sum(Ethnic_Code_Text == "Caucasian"),
    black = sum(Ethnic_Code_Text == "African-American"),
    black = black + sum(Ethnic_Code_Text == "African-Am"),
    arabic = sum(Ethnic_Code_Text == "Arabic"),
    asian = sum(Ethnic_Code_Text == "Asian"),
    hispanic = sum(Ethnic_Code_Text == "Hispanic"),
    amerindian = sum(Ethnic_Code_Text == "Native American"),
    oriental = sum(Ethnic_Code_Text == "Oriental"),
    other = sum(Ethnic_Code_Text == "Oriental")
  ) %>%
  arrange(-risk)

white_considered_high <- inmate_risk %>%
  filter(RecSupervisionLevelText == "High") %>%
  pull(white)

black_considered_high <- inmate_risk %>%
  filter(RecSupervisionLevelText == "High") %>%
  pull(black)

times <- round(black_considered_high / white_considered_high)

arrests_by_race <- group_by(arrests, RACE) %>%
  summarise(
    arrests = n(),
    mean_age = mean(AGE)
  )

most_arrests <- arrests_by_race %>%
  filter(arrests == max(arrests)) %>%
  pull(RACE)

reasons_for_arrest <- group_by(arrests, STATUTE.DESCRIPTION) %>%
  summarise(
    num_arrests = n(),
    white_arrests = sum(RACE == "WHITE"),
    black_arrests = sum(RACE == "BLACK"),
    white_hispanic_arrests = sum(RACE == "WHITE HISPANIC"),
    black_hispanic_arrests = sum(RACE == "BLACK HISPANIC"),
    asian_pac_island_arrests = sum(RACE == "ASIAN PACIFIC ISLANDER"),
    amerindian_arrests = sum(RACE == "AMERICAN INDIAN / ALASKA NATIVE"),
    unknown_arrests = sum(RACE == "UNKNOWN"),
    mean_age_to_commit = mean(AGE)
  ) %>%
  arrange(-num_arrests)

main_reason <- reasons_for_arrest %>%
  filter(black_arrests == max(black_arrests)) %>%
  pull(STATUTE.DESCRIPTION)

# what the hell even are these variable names
labour_by_year <- na.omit(labour) %>%
  group_by(Year) %>%
  summarise(
    white_unemployment = mean(White.Alone.Unemployment.Rate),
    black_unemployment =
      mean(Black.or.African.American.Alone.Unemployment.Rate),
    asian_unemployment = mean(Asian.Alone.Unemployment.Rate),
    latin_unemployment = mean(Hispanic.or.Latino.Unemployment.Rate)
  )
