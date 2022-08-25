library(gridstackeR)

test_that("grid_stack works", {
  stack_actual_simple <- paste0(grid_stack())
  stack_expected_simple <- '<div class="grid-stack" id="gridstackeR-grid"></div>
<script>initGridstackeR({cellHeight: 70}, \'gridstackeR-grid\', 12, 12, false, 0);</script>'
  expect_equal(stack_actual_simple, stack_expected_simple)


  stack_actual_advanced <- paste0(grid_stack(shiny::div("content"), id = "custom_id", opts = "{cellHeight: 90}", ncols = 10,
    nrows = 8, dynamic_full_window_height = TRUE, height_offset = 50))
  stack_expected_advanced <- '<div class="grid-stack" id="custom_id">
  <div>content</div>
</div>
<script>initGridstackeR({cellHeight: 90}, \'custom_id\', 10, 8, true, 50);</script>'

  expect_equal(stack_actual_advanced, stack_expected_advanced)
})

