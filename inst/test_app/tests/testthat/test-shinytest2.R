library(shinytest2)

test_that("test save_grid_layout", {
  app <- AppDriver$new(name = "test_save_grid_layout",
                       expect_values_screenshot_args = FALSE)
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test save_grid_layout_ns", {
  app <- AppDriver$new(name = "test_save_grid_layout_ns",
                       expect_values_screenshot_args = FALSE)
  app$click("save_grid_layout_ns")
  app$expect_values(output = c("result_ns"))
})

test_that("test add_grid_element", {
  app <- AppDriver$new(name = "test_add_grid_element",
                       expect_values_screenshot_args = FALSE)
  app$click("add_grid_element")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test load_grid_layout", {
  app <- AppDriver$new(name = "test_load_grid_layout",
                       expect_values_screenshot_args = FALSE)
  app$click("load_grid_layout")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test nested Grid", {
  app <- AppDriver$new(name = "test_nested_grid",
                       expect_values_screenshot_args = FALSE)
  app$click("add_grid")
  app$click("add_grid_element_nested")
  app$click("add_grid_element_nested")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})



test_that("test_save_grid_layout_nested", {
  app <- AppDriver$new(name = "test_save_grid_layout_nested",
                       expect_values_screenshot_args = FALSE)
  app$click("add_grid")
  app$click("add_grid_element_nested")
  app$click("add_grid_element_nested")
  app$click("save_grid_layout_nested")
  app$expect_values(output = c("result_nested"))
})


test_that("test_remove_all_grid_elements", {
  app <- AppDriver$new(name = "test_remove_all_grid_elements",
                       expect_values_screenshot_args = FALSE)
  app$click("remove_all_grid_elements")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test_remove_grid_element", {
  app <- AppDriver$new(name = "test_remove_grid_element",
                       expect_values_screenshot_args = FALSE)
  app$click("remove_grid_element")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})
