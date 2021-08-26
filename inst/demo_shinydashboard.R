library(gridstackeR)
library(shiny)
library(shinydashboard)
library(shinyjs)


ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    useShinyjs(),
    # make sure the content fills the given height
    tags$style(".grid-stack-item-content .col-sm-12{height:100%;}"),
    actionButton("save", "Save"),
    actionButton("load", "Load"),
    grid_stack(
      grid_stack_item(
        h = 4, w = 4, id = "plot_container", style = "overflow:hidden",
        box(
          title = "Histogram", status = "primary", solidHeader = TRUE,  width = 12, height = "100%",
          plotOutput("plot3", height = "auto")
        )
      ),
      grid_stack_item(
        h = 3, w = 4, minH = 3, maxH = 3, id = "slider", style = "overflow:hidden",
        box(
          title = "Inputs", status = "warning", solidHeader = TRUE, width = 12, height = "100%",
          sliderInput("slider", "Slider input:", 1, 100, 50)
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$plot3 <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$slider + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

  }, height = function() {max(input$plot_container_height - 80, 150)}
  )

  observeEvent(input$save, {
    js$save_grid_stack()
  })

  observeEvent(input$load, {
    js$load_grid_stack('[
    {
        "w": 4,
        "h": 3,
        "maxH": 3,
        "minH": 3,
        "id": "slider",
        "x": 0,
        "y": 0,
        "content": "\n              <div class=\"col-sm-12\">\n                <div class=\"box box-solid box-warning\" style=\"height: 100%\">\n                  <div class=\"box-header\">\n                    <h3 class=\"box-title\">Inputs</h3>\n                  </div>\n                  <div class=\"box-body\">\n                    <div class=\"form-group shiny-input-container\">\n                      <label class=\"control-label\" id=\"slider-label\" for=\"slider\">Slider input:</label>\n                      <span class=\"irs irs--shiny js-irs-0 irs-with-grid\"><span class=\"irs\"><span class=\"irs-line\" tabindex=\"0\"></span><span class=\"irs-min\" style=\"visibility: visible;\">1</span><span class=\"irs-max\" style=\"visibility: visible;\">100</span><span class=\"irs-from\" style=\"visibility: hidden;\">0</span><span class=\"irs-to\" style=\"visibility: hidden;\">0</span><span class=\"irs-single\" style=\"left: 46.1146%;\">50</span></span><span class=\"irs-grid\" style=\"width: 91.7497%; left: 4.02517%;\"><span class=\"irs-grid-pol\" style=\"left: 0%\"></span><span class=\"irs-grid-text js-grid-text-0\" style=\"left: 0%; margin-left: -2.06551%;\">1</span><span class=\"irs-grid-pol small\" style=\"left: 6.7340067340067336%\"></span><span class=\"irs-grid-pol small\" style=\"left: 3.3670033670033668%\"></span><span class=\"irs-grid-pol\" style=\"left: 10.1010101010101%\"></span><span class=\"irs-grid-text js-grid-text-1\" style=\"left: 10.101%; visibility: visible; margin-left: -2.87708%;\">11</span><span class=\"irs-grid-pol small\" style=\"left: 16.835016835016834%\"></span><span class=\"irs-grid-pol small\" style=\"left: 13.468013468013467%\"></span><span class=\"irs-grid-pol\" style=\"left: 20.2020202020202%\"></span><span class=\"irs-grid-text js-grid-text-2\" style=\"left: 20.202%; visibility: visible; margin-left: -3.00305%;\">21</span><span class=\"irs-grid-pol small\" style=\"left: 26.936026936026934%\"></span><span class=\"irs-grid-pol small\" style=\"left: 23.569023569023567%\"></span><span class=\"irs-grid-pol\" style=\"left: 30.3030303030303%\"></span><span class=\"irs-grid-text js-grid-text-3\" style=\"left: 30.303%; visibility: visible; margin-left: -3.00305%;\">31</span><span class=\"irs-grid-pol small\" style=\"left: 37.03703703703704%\"></span><span class=\"irs-grid-pol small\" style=\"left: 33.67003367003367%\"></span><span class=\"irs-grid-pol\" style=\"left: 40.4040404040404%\"></span><span class=\"irs-grid-text js-grid-text-4\" style=\"left: 40.404%; margin-left: -3.00305%;\">41</span><span class=\"irs-grid-pol small\" style=\"left: 47.138047138047135%\"></span><span class=\"irs-grid-pol small\" style=\"left: 43.77104377104377%\"></span><span class=\"irs-grid-pol\" style=\"left: 50.505050505050505%\"></span><span class=\"irs-grid-text js-grid-text-5\" style=\"left: 50.5051%; visibility: visible; margin-left: -3.00305%;\">51</span><span class=\"irs-grid-pol small\" style=\"left: 57.23905723905724%\"></span><span class=\"irs-grid-pol small\" style=\"left: 53.87205387205387%\"></span><span class=\"irs-grid-pol\" style=\"left: 60.6060606060606%\"></span><span class=\"irs-grid-text js-grid-text-6\" style=\"left: 60.6061%; visibility: visible; margin-left: -3.00305%;\">61</span><span class=\"irs-grid-pol small\" style=\"left: 67.34006734006734%\"></span><span class=\"irs-grid-pol small\" style=\"left: 63.973063973063965%\"></span><span class=\"irs-grid-pol\" style=\"left: 70.7070707070707%\"></span><span class=\"irs-grid-text js-grid-text-7\" style=\"left: 70.7071%; visibility: visible; margin-left: -3.00305%;\">71</span><span class=\"irs-grid-pol small\" style=\"left: 77.44107744107744%\"></span><span class=\"irs-grid-pol small\" style=\"left: 74.07407407407406%\"></span><span class=\"irs-grid-pol\" style=\"left: 80.8080808080808%\"></span><span class=\"irs-grid-text js-grid-text-8\" style=\"left: 80.8081%; margin-left: -3.00305%;\">81</span><span class=\"irs-grid-pol small\" style=\"left: 87.54208754208754%\"></span><span class=\"irs-grid-pol small\" style=\"left: 84.17508417508417%\"></span><span class=\"irs-grid-pol\" style=\"left: 90.9090909090909%\"></span><span class=\"irs-grid-text js-grid-text-9\" style=\"left: 90.9091%; visibility: visible; margin-left: -3.00305%;\">91</span><span class=\"irs-grid-pol small\" style=\"left: 96.96969696969697%\"></span><span class=\"irs-grid-pol small\" style=\"left: 93.93939393939394%\"></span><span class=\"irs-grid-pol\" style=\"left: 100%\"></span><span class=\"irs-grid-text js-grid-text-10\" style=\"left: 100%; visibility: visible; margin-left: -3.94351%;\">100</span></span><span class=\"irs-bar irs-bar--single\" style=\"left: 0px; width: 49.5366%;\"></span><span class=\"irs-shadow shadow-single\" style=\"display: none;\"></span><span class=\"irs-handle single\" style=\"left: 45.4115%;\"><i></i><i></i><i></i></span></span><input class=\"js-range-slider shinyjs-resettable irs-hidden-input shiny-bound-input\" id=\"slider\" data-skin=\"shiny\" data-min=\"1\" data-max=\"100\" data-from=\"50\" data-step=\"1\" data-grid=\"true\" data-grid-num=\"9.9\" data-grid-snap=\"false\" data-prettify-separator=\",\" data-prettify-enabled=\"true\" data-keyboard=\"true\" data-data-type=\"number\" data-shinyjs-resettable-id=\"slider\" data-shinyjs-resettable-type=\"Slider\" data-shinyjs-resettable-value=\"50\" tabindex=\"-1\" readonly=\"\">\n                    </div>\n                  </div>\n                </div>\n              </div>\n            "
    },
    {
        "w": 4,
        "h": 4,
        "id": "plot_container",
        "x": 5,
        "y": 0,
        "content": "\n              <div class=\"col-sm-12\">\n                <div class=\"box box-solid box-primary\" style=\"height: 100%\">\n                  <div class=\"box-header\">\n                    <h3 class=\"box-title\">Histogram</h3>\n                  </div>\n                  <div class=\"box-body\">\n                    <div id=\"plot3\" class=\"shiny-plot-output shiny-bound-output\" style=\"width:100%;height:auto;\" aria-live=\"polite\"><img src=\"data:image/png;base64,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\" width=\"267\" height=\"150\" alt=\"Plot object\"></div>\n                  </div>\n                </div>\n              </div>\n            "
    }
]')
  })



}

shinyApp(ui, server)
