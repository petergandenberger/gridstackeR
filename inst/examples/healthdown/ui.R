ui <- function() {
  tagList(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style-app.css")
    ),
    # we need shinyjs for the leafdown map
    useShinyjs(),

    # ---- header
    tags$header(
      class = "site-header",
      div(
        style = "padding: 0 20px;",
        class="wrapper site-header__wrapper",
        a(href="https://github.com/petergandenberger/gridstackeR", target="_blank", img(src = "hex-gridstackeR.png", height = "100px"), style = "margin-right: 10px;"),
        a(href="https://github.com/hoga-it/leafdown", target="_blank", img(src = "hex-leafdown.png", height = "100px")),
        div(
          style = "margin: 0 20px;",
          actionButton("view_map", "Map View", style = "width:100%;", class = "healthdown-button"),
          actionButton("view_full", "Full Map", style = "width:100%;", class = "healthdown-button"),
          actionButton("view_overview", "Overview", style = "width:100%;", class = "healthdown-button")
        ),
        selectInput(
          inputId = "year",
          label = "Select the Year",
          choices = all_years,
          selected = max(all_years)
        ),
        selectInput(
          inputId = "prim_var",
          label = "Select the Primary Variable",
          choices = all_vars,
          selected = all_vars[1]
        ),
        selectInput(
          inputId = "sec_var",
          label = "Select the Secondary Variable",
          choices = all_vars,
          selected = all_vars[2]
        )
      )
    ),
    tags$hr(),
    # ---- second row
    grid_stack(
      dynamic_full_window_height = TRUE,
      id = "grid_stack",
      grid_stack_item(
        w = 2, h = 10, x = 0, y = 0, id =  "c_table",
        DT::dataTableOutput("mytable")
      ),
      grid_stack_item(
        w = 5, h = 5, x = 2, y = 0, id = "c_map",
        actionButton("drill_down", "Drill Down", icon = icon("arrow-down"), class = "healthdown-button"),
        actionButton("drill_up", "Drill Up", icon = icon("arrow-up"), class = "healthdown-button"),
        leafletOutput("leafdown", height = "calc(100% - 50px)")
      ),
      grid_stack_item(
        w = 5, h = 5, x = 7, y = 0, id = "c_bar",
        echarts4rOutput(outputId =  "bar", height = "100%")
      ),
      grid_stack_item(
        w = 5, h = 5, x = 2, y = 5, id =  "c_line",
        echarts4rOutput(outputId =  "line", height = "100%")
      ),
      grid_stack_item(
        w = 5, h = 5, x = 7, y = 5, id =  "c_scatter",
        echarts4rOutput(outputId =  "scatter", height = "100%")
      )
    )
  )
}
