## following https://github.com/mitchelloharawild/vitae/blob/master/tests/testthat/test-template.R
expect_knit <- function(template) {
    outd <- tempfile()
    if (!dir.exists(outd)) dir.create(outd)
    file.copy(system.file("rmarkdown", "templates", template, "skeleton", "skeleton.Rmd", package = "ovpaged"), outd)
    expect_output(expect_message(rmarkdown::render(file.path(outd, "skeleton.Rmd"), output_dir = outd), "Output created"), "pandoc")
    unlink(outd, recursive = TRUE)
}
test_that("simple template works", expect_knit("simple"))

test_that("simple_landscape template works", expect_knit("simple_landscape"))

test_that("plain template works", expect_knit("plain"))

test_that("poster template works", expect_knit("poster"))
