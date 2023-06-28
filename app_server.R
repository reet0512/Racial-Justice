library("shiny")
library("dplyr")
library("ggplot2")
library("plotly")
library("lintr")

source("scripts/Chart 1.R")
source("scripts/Chart 2.R")
source("scripts/Chart.R")

server <- function(input, output) {
  output$summary_table <- renderTable({
    table <- read.csv("scripts/data/Summary_table.csv") %>%
      filter(Race == input$summary_race) %>%
      filter(Date == input$summary_year)

    return(table)
  })
  output$interactive_1 <- renderPlotly({
    races <- substring(input$race_1, 1, 1)
    interactive_1_df <- shootings %>%
      filter(race %in% races) %>%
      filter(threat_level %in% input$intent_1) %>%
      group_by(race)
    make_chart_1(interactive_1_df)
  })
  output$interactive_2 <- renderPlotly({
    interactive_2_df1 <- compas %>%
      filter(race == input$page_2_input1)
    interactive_2_df2 <- compas %>%
      filter(race == input$page_2_input2)
    interactive_2_df <- bind_rows(
      interactive_2_df1,
      interactive_2_df2
    )
    chart_21 <- draw_chart_2(interactive_2_df)
    return(chart_21)
  })
  output$interactive_3 <- renderPlotly({
    return(draw_chart_3(compas, input$page_3_input))
  })
}
