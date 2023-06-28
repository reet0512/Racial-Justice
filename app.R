library("shiny")
library("dplyr")
library("ggplot2")
library("lintr")
library("plotly")

source("app_server.R")
source("app_ui.R")
shinyApp(ui = ui, server = server)
