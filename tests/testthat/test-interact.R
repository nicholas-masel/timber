test_that("set_log_element works", {
   log_init()

   # list of attributes to add to the log
   keys <- list(
      "value",
      "list")

   for (key in 1:length(keys)){
      assign(keys[[key]], NA, envir = getOption('timber.log'))
   }

   v <- 1
   set_log_element("value", v)

   l <- list(a = 1, b = 2, c = 3)
   set_log_element("list", l)

   testthat::expect_identical(getOption("timber.log")[["value"]],
                              v)

   testthat::expect_identical(getOption("timber.log")[["list"]],
                              l)

   log_remove()
})

test_that("get_log_element works", {
   log_init()

   # list of attributes to add to the log
   keys <- list(
      "value",
      "list")

   for (key in 1:length(keys)){
      assign(keys[[key]], NA, envir = getOption('timber.log'))
   }

   v <- 1
   set_log_element("value", v)

   l <- list(a = 1, b = 2, c = 3)
   set_log_element("list", l)

   testthat::expect_identical(get_log_element("value"),
                              v)

   testthat::expect_identical(get_log_element("list"),
                              l)

   log_remove()
})

test_that("setting log name works", {
   log_init()

   # list of attributes to add to the log
   keys <- list(
      "file_name",
      "file_path",
      "log_name",
      "log_path")

   for (key in 1:length(keys)){
      assign(keys[[key]], NA, envir = getOption('timber.log'))
   }

   log_name <- "test_log_name"

   set_log_name_path(log_name = log_name)

   testthat::expect_identical(getOption("timber.log")[["log_name"]],
                              log_name)
   testthat::expect_warning(set_log_name_path(log_name = "test_log_name2"))

   log_remove()
})

test_that("setting path name works", {
   log_init()

   # list of attributes to add to the log
   keys <- list(
      "file_name",
      "file_path",
      "log_name",
      "log_path")

   for (key in 1:length(keys)){
      assign(keys[[key]], NA, envir = getOption('timber.log'))
   }

   log_path <- "test_log_path"

   set_log_name_path(log_path = log_path)

   testthat::expect_identical(getOption("timber.log")[["log_path"]],
                              log_path)
   testthat::expect_warning(set_log_name_path(log_path = "."))

   log_remove()
})

test_that("run_safely_n_quietly works", {
   scriptPath <- tempfile()
   logDir <- tempdir()

   writeLines("log(-1)
              log(a)", con = scriptPath)

   log_config(file = scriptPath)

   run_safely_n_quietly(scriptPath)

   testthat::expect_true(!is.null(getOption("timber.log")[["warnings"]]))
   testthat::expect_true(!is.null(getOption("timber.log")[["errors"]]))

   log_remove()
})
