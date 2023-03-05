library(gridstackeR)

test_that("grid_stack_item works", {
  item_actual_simple <- paste0(grid_stack_item())
  item_expected_simple <-
    paste0("<div class=\"grid-stack-item\" gs-id=\"\" gs-auto-position=\"\" gs-w=\"\" ",
           "gs-h=\"\" gs-x=\"\" gs-y=\"\" gs-max-w=\"\" gs-min-w=\"\" gs-max-h=\"\" ",
           "gs-min-h=\"\" gs-locked=\"\" gs-no-resize=\"\" gs-no-move=\"\" ",
           "gs-resize-handles=\"\">\n  <div class=\"grid-stack-item-content\" style=\"overflow:hidden;\"></div>\n</div>")
  expect_equal(item_actual_simple, item_expected_simple)


  item_actual_advanced <- paste0(
    grid_stack_item(shiny::div("item_content"), id = "item_id",
     x = 1, y = 2, w = 3, h = 4,
     max_w = 5, min_w = 1, max_h = 5, min_h = 1,
     locked = TRUE, no_resize = TRUE, no_move = TRUE, resize_handles = 'e,w')
  )

  item_expected_advanced <-
    paste0("<div class=\"grid-stack-item\" gs-id=\"item_id\" gs-auto-position=\"\" ",
           "gs-w=\"3\" gs-h=\"4\" gs-x=\"1\" gs-y=\"2\" gs-max-w=\"5\" gs-min-w=\"1\" ",
           "gs-max-h=\"5\" gs-min-h=\"1\" gs-locked=\"TRUE\" gs-no-resize=\"TRUE\" ",
           "gs-no-move=\"TRUE\" gs-resize-handles=\"e,w\">\n  ",
           "<div class=\"grid-stack-item-content\" id=\"item_id\" style=\"overflow:hidden;\">\n    ",
           "<div>item_content</div>\n  </div>\n</div>")

  expect_equal(item_actual_advanced, item_expected_advanced)
})

