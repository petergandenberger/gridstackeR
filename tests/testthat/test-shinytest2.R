library(shinytest2)

test_that("test save_grid_layout", {
  app <- AppDriver$new(name = "test save_grid_layout", app = "../",
                       expect_values_screenshot_args = FALSE)
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test save_grid_layout_ns", {
  app <- AppDriver$new(name = "test save_grid_layout_ns", app = "../",
                       expect_values_screenshot_args = FALSE)
  app$click("save_grid_layout_ns")
  app$expect_values(output = c("result_ns"))
})

test_that("test add_grid_element", {
  app <- AppDriver$new(name = "test add_grid_element", app = "../",
                       expect_values_screenshot_args = FALSE)
  app$click("add_grid_element")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test load_grid_layout", {
  app <- AppDriver$new(name = "test load_grid_layout", app = "../",
                       expect_values_screenshot_args = FALSE)
  app$click("load_grid_layout")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})


test_that("test nested Grid", {
  app <- AppDriver$new(name = "test nested Grid", app = "../",
                       expect_values_screenshot_args = FALSE)
  app$click("add_grid")
  app$click("add_grid_element_nested")
  app$click("add_grid_element_nested")
  app$click("save_grid_layout")
  app$expect_values(output = c("result"))
})
