library(gridstackeR)

test_that("grid_stack works", {
  set.seed('42')
  stack_actual_simple <- paste0(grid_stack())
  stack_expected_simple <- '<div class="grid-stack" id="gridstackeR-grid2369"></div>
<script>initGridstackeR({cellHeight: 70}, \'gridstackeR-grid2369\', 12, 12, false, 0);</script>'
  expect_equal(stack_actual_simple, stack_expected_simple)


  stack_actual_advanced <- paste0(grid_stack(grid_stack_item(shiny::div("content")), id = "custom_id", opts = "{cellHeight: 90}", ncols = 10,
    nrows = 8, dynamic_full_window_height = TRUE, height_offset = 50))
  stack_expected_advanced <- '<div class="grid-stack" id="custom_id">
  <div class="grid-stack-item" gs-id="" gs-auto-position="" gs-w="" gs-h="" gs-x="" gs-y="" gs-max-w="" gs-min-w="" gs-max-h="" gs-min-h="" gs-locked="" gs-no-resize="" gs-no-move="" gs-resize-handles="">
    <div class="grid-stack-item-content" style="overflow:hidden;">
      <div>content</div>
    </div>
  </div>
</div>
<script>initGridstackeR({cellHeight: 90}, \'custom_id\', 10, 8, true, 50);</script>'

  expect_equal(stack_actual_advanced, stack_expected_advanced)
})

test_that("grid_stack can only contain grid_stack_items", {
  expect_error(grid_stack(shiny::div("test")), "Arguments passed in the ... must be grid_stack_items")
  expect_error(grid_stack(grid_stack_item()), NA)
})

