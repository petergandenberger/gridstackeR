
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gridstackeR

The gridstackeR package allows users to easily create Dashboards with
[gridstack.js](https://gridstackjs.com/) functionalities

‘gridstack.js is \[…\] designed to help developers create beautiful
draggable, resizable, responsive \[…\] layouts with just a few lines of
code’

<img src='man/figures/healthdown_example.gif'/>

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("petergandenberger/gridstackeR")
```

## Example

In the example below we add gridstackeR to the basic shiny application
‘Old Faithful Geyser’. The plot can now be dynamically resized and the
position for both, the plot and the slider, can be changed using simple
drag&drop.

``` r
library(shiny)
library(gridstackeR)
ui <- fluidPage(
  grid_stack(
    grid_stack_item(
      h = 4, w = 4, id = "plot_container",
      plotOutput("plot", height = "auto")
    ),
    grid_stack_item(
      h = 2, w = 3, no_resize = TRUE, id = "slider",
      sliderInput("slider", "Slider input:", 1, 100, 50)
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$slider + 1)

    hist(
      x, breaks = bins, col = "#75AADB", border = "white", 
      xlab = "Waiting time to next eruption (in mins)", 
      main = "Histogram of waiting times"
    )
  },
  # set the height according to the container height (minus the margins)
  height = function() {
    min_height <- 150
    margin <- 20
    max(input$plot_container_height - margin, min_height)
  })
}

shinyApp(ui, server)
```

## Usage

In the `ui.R` file, create a grid using `grid_stack(...)` and place
grid-stack-items inside using `grid_stack_item(...)`.

Specify options like height, width, x-, y-position as well. Check the
[gridstack.js
documentation](https://github.com/gridstack/gridstack.js/tree/master/doc#item-options)
for a full list of options.

The `ui.R` file might contain something like the following.

``` r
grid_stack(
  grid_stack_item(
    h = 4, w = 4, id = "plot_container",
    plotOutput("plot", height = "auto")
  )
)
```

## Reactive Inputs

Every `grid_stack_item` has four reactive inputs that can be used to
observe changes made to the element.

- `<grid_stack_item-id>_width` returns the width of the item in pixels
- `<grid_stack_item-id>_height` returns the height of the item in pixels
- `<grid_stack_item-id>_w` returns the width of the item in number of
  rows
- `<grid_stack_item-id>_h` returns the height of the item in number of
  columns
- `<grid_stack_item-id>_x` returns the x-position of the item in number
  of columns
- `<grid_stack_item-id>_y` returns the y-position of the item in number
  of rows

E.g. to observe the width (in pixels) of the grid_stack_item created in
the section above use `observe({print(input$plot_container_width)})`.
This can be used to set the width of a plot manually.

## Dynamic figure height

Elements inside `grid-stack-item` might not change their height
automatically.

### Setting the height dynamically using callbacks

The following example shows how the height of the plot can be set
dynamically using the `<id>_height` callback

Note: the `plot_container_height` references the height of the
`id = "plot_container"` created in the `ui.R` example above.

``` r
output$plot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$slider + 1)

    hist(
      x, breaks = bins, col = "#75AADB", border = "white", 
      xlab = "Waiting time to next eruption (in mins)", 
      main = "Histogram of waiting times"
    )
  },
  # set the height according to the container height (minus the margins)
  height = function() {
    min_height <- 150
    margin <- 20
    max(input$plot_container_height - margin, min_height)
  }
)
```

### Setting the height for [DT::dataTableOutput](https://rstudio.github.io/DT/)

The height for a `DT::dataTableOutput` can be set as in the following
example.

ui.R

``` r
grid_stack_item(
        w = 4, h = 10, x = 0, y = 0, id =  "c_table",
        DT::dataTableOutput("mytable")
      )
```

server.R

``` r
output$mytable <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(
      # set the height according to the container height (minus the margins)
      scrollY = max(input$c_table_height, 200) - 110, paging = FALSE
      )
    )
  })
```

### Setting the height for [echarts4r](https://github.com/JohnCoene/echarts4r)

The height for a `echarts4r::echarts4rOutput` can easily be set using
the `height="100%"` option.

ui.R

``` r
grid_stack_item(
 w = 5, h = 5, x = 7, y = 0, id = "c_plot",
 echarts4rOutput(outputId =  "plot", height = "100%")
)
```
