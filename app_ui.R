library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

# Overview page : About data of the project
overview_tab <- tabPanel(
  "Overview",
  tags$h2(class = "title", id = "overview_title",
          "Racial Justice and Injustice"),
  tags$p(class = "paragraph",
         "2020 is a special year, and this year in US, policeman shot ",
         "African American for almost no reason triggered people's ",
         "anger again and again. This always reminds us that racial ",
         "justice is a very common and serious topic in the US. ",
         "In this report, we will understand racial justice more ",
         "comprehensively. We will not only just have a basic concept ",
         "about racial justice, but also we will know how racial justice ",
         "expresses in different fields. We will achieve this by doing ",
         "analysis on data sets about ",
         tags$a(href = paste0("https://kaggle.com/danofer/compass?select",
                            "=compas-scores-raw.csv"),
                "COMPAS Recidivism Racial Bias"), ", ",
         tags$a(href = paste0("https://catalog.data.gov/dataset/labor-force-",
                            "status-by-race-and-ethnicity-beginning-2012"),
                "Unemployment Rate by Race and Ethnicity"), ", ",
         tags$a(href = "https://justicedivided.com/download-data",
                "Juvenile Arrests"), ", and ",
         tags$a(href = paste0("https://github.com/washingtonpost/data-police",
                            "-shootings"),
                "US Police Shootings"),
         img(src = "./blm.jpg", alt = "BLM", class="overview_pic", width = 800, height = 600)),
)

# summary takeaways page:
summary_sidebar <- sidebarPanel(
  radioButtons(
    inputId = "summary_race",
    label = "Select the race for which you want to filter information",
    choices = list("WHITE", "BLACK", "WHITE HISPANIC", "BLACK HISPANIC",
                "ASIAN PACIFIC ISLANDER", "AMERICAN INDIAN / ALASKAN NATIVE",
                "UNKNOWN"),
    selected = NULL
  ),
  radioButtons(
    inputId = "summary_year",
    label = "Select the year for which you want to filter information",
    choices = list("2013", "2014", "2015", "2016"),
    selected = NULL
  )

)

summary_main <- mainPanel(
  tags$h2(class = "title", "Summary Info"),
  # summary 1
  tags$p(class = "paragraph",
         HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"),
         "From the data set of inmates, we can see that African-Americans ",
         "make up the majority of inmates. Among these, 3030 were ",
         "considered at a high risk level, which is 5 times the ",
         "numbers of white inmates with the same risk level. This ",
         "wide gap between the statistics of two racial groups",
         "suggests that black inmates might be wrongly considered as ",
         "high risk solely due to the colour of their skin. From the ",
         "data set of juvenile arrests, we can see Black people are ",
         "arrested more often than other races, and the main reason ",
         "given is 'Issuance of Warrant', which is not only unreasonable, ",
         "but also incredibly vaue and non-specific. It shows the",
         "prejudice people have against African Americans. The data set ",
         "of unemployment rate also shows that African-Americans are the ",
         "group with the highest unemployment rate. From all of these ",
         "data sets, we can see the magnitude of racial injustice in the US."
  ),
  tableOutput(
    outputId = "summary_table"
  ),
  tags$p(class = "paragraph",
         HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"),
         "While it is easy to deduce that certain races and ethnicities ",
         "are targeted more by law enforcement than others, the data ",
         "doesn't show the reason ", em("why"), " this is. In order to ",
         "figure out the cause, supplemental information is needed, which ",
         "extends well beyond the purpose of this dataset. A documentary ",
         "such as '13th' by Ava DuVernay (which is free to watch on ",
         "YouTube), or a book like 'Punished' by Victor Rios, are good ",
         "places to start."
  ),
  
  tags$p(class = "paragraph",
         HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"),
         "From page Fatal Police Shootings, the chart shows that the majority ",
         "of fatal police shootings involved the black, hispanic, and white ",
         "people. Unsurprisingly, the majority of the victims had violent ",
         "intentions and blacks had the highest percentage of aggressive ",
         "intent at 67.11% followed closely by whites at 66.14%.<br>",
         "The difference in victims between the other 3 races (including ",
         "other as one) is quite slim however the length visualisation helps ",
         "realise that Asians are affected more than the Native Americans."
  ),
  tags$p(class = "paragraph",
         "From a wider standpoint many biases can occur regarding the amount ",
         "of cases reported and the undetermined intentions could be a cover ",
         "to hide facts. However the conclusion still stands that the race ",
         "that was viewed as the most agressive by police was the blacks."
  ),
  
  tags$p(class = "paragraph",
         HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"),
         "From page COMPAS Scores Comparison, the chart shows that scores",
         "for Caucasian defendants were skewed toward lower-risk categories,",
         "while African-American defendants were evenly distributed across",
         "scores. Notice that all the defendants in this chart are those who",
         "had not been arrested for a new offense or who had recidivated",
         "within two years. This chart also shows for the defendants who had",
         "not recidivated within two years, the number of African-American",
         "defendants who were categorized as the highest-risk(decile score",
         "is 10) is about the same as the number of Caucasian defendants who",
         "were categorized as the medium-risk(about score 5), or the same as",
         "the number of Hispanic or other races defendants who were",
         "categorized as the lowest-risk(about score 2.5). Notice that the",
         "number is the same but how the campas scores of recidivism are",
         "different."
         ),
  tags$p(class = "paragraph",
         "To think of this in a boarder view, although there are",
         "many factors the data is not taken into account like crime rate",
         "and regions, it still reveals people would probably think some races",
         "are more dangerous then others, and label them as high-risks."
         ),

 tags$p(class = "paragraph",
        HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"), HTML("&nbsp"),
        "From page COMPAS Scores Factors, the chart shows that when other",
        "variables like age or sex are controlled as the same, the race will",
        "be a factor for COMPAS scoring, and the difference for each races is",
        "significant. Also, being an African-American will have the highest",
        "chance of being scored as high-risk while being Hispanic(apart from",
        "the category \"Other\") will have the lowest."
        ),
 tags$p(class = "pargraph",
        "This data shows when controlling the normal factors like age or",
        "gender, the race then unbelievably becomes a factor that will",
        "influence the COMPAS scores. This data may not be perfect, but it ",
        "shows that we still have a long way to go on racial justice, and",
        "actually it's not just us, but also algorithms"
        )
)



summary_tab <- tabPanel(
  "Summary",
  sidebarLayout(
    summary_sidebar,
    summary_main
  )
)

interactive_1_sidepanel <- sidebarPanel(
  tags$p(class = "interactive_para",
         tags$b("The bar graph displays the number of fatal police shootings ",
         "grouped by race and also indicates the intent of victim, whether ",
         "attack, other or undetermined")),
  checkboxGroupInput(
    inputId = "race_1",
    label = "Select the races for which you want to compare information",
    choices = c("Asian", "Black", "Hispanic", "Native American",
                   "Other", "White"),
    selected = c("Black", "Hispanic", "White")
  ),
  checkboxGroupInput(
    inputId = "intent_1",
    label = "Choose the intent of the victim",
    choices = c("attack", "other", "undetermined"),
    selected = c("attack", "other", "undetermined")
  )
)

interactive_1_mainpanel <- mainPanel(
  plotlyOutput(outputId = "interactive_1")
)

# interactive page 1 : explores the data
interactive_tab_1 <- tabPanel(
  "Fatal Police Shootings",
  tags$h2(class = "title", id = "interactive_1_title",
          "Fatal Police Shootings Based on Race and Intent"),
  interactive_1_sidepanel,
  interactive_1_mainpanel
)

# interactive page 2:
interactive_2_sidepanel <- sidebarPanel(
  p("COMPAS scores, ranging from 1 to 10, represent the risk of recidivism."),
  p("Please choose between which two races' COMPAS scores you want to compare"),
  selectInput(inputId = "page_2_input1",
              label = "the first race you want to choose",
              choices = c("African-American", "Asian", "Caucasian",
                          "Hispanic", "Native American", "Other")
  ),
  selectInput(inputId = "page_2_input2",
              label = "the second race you want to choose",
              choices = c("African-American", "Asian", "Caucasian",
                          "Hispanic", "Native American", "Other"),
              selected = c("African-American", "Caucasian")
  )
)

interactive_2_mainpanel <- mainPanel(
  plotlyOutput(outputId = "interactive_2")
)

interactive_tab_2 <- tabPanel(
  "COMPAS Scores Comparison",
  tags$h2(class = "title", "Different COMPAS scores based on race"),
  interactive_2_sidepanel,
  interactive_2_mainpanel
)

# interactive page 3:
interactive_3_sidepanel <- sidebarPanel(
  tags$p(class = "interactive_para",
         tags$b("This graph indicates how races could be a factor that",
                "influences the COMPAS score by removing all other factors",
                "like ages or genders"),
         "When the number on the y axis is higher than 0, it means being this",
         "particular race will have more chance of being categorized as",
         "high-supervision (scored as medium or high, or >= 5), vice versa",
         "Also the bigger the number is, the greater the chance is, vice versa"
         ),

  checkboxGroupInput(
    inputId = "page_3_input",
    label = "Choose the races",
    choices = c("African-American", "Asian", "Caucasian",
                "Hispanic", "Native American", "Other"),
    selected = c("Caucasian", "Native American")
  )
)

interactive_3_mainpanel <- mainPanel(
  plotlyOutput(outputId = "interactive_3")
)
  
interactive_tab_3 <- tabPanel(
  "COMPAS Scores Factors",
  tags$h2(class = "title", "How COMPAS scores is related to races"),
  interactive_3_sidepanel,
  interactive_3_mainpanel
)

# define ui for shinyapp
ui <- fluidPage(
  includeCSS("app_style.css"),
  navbarPage(
    "Racial Justice",
    overview_tab,
    interactive_tab_1,
    interactive_tab_2,
    interactive_tab_3,
    summary_tab
  )
)