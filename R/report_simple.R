#' Simple paged report template
#'
#' @param css string: additional css
#' @param ... : passed to [pagedown::html_paged()]
#'
#' @return A pagedown template
#' @export
simple <- function(css = NULL, ...){
    pagedown::html_paged(css = c(pkg_resource("css", "style_simple.css"), css), template = pkg_resource("html", "template_simple.html"), ...)
}

#' @rdname simple
#' @export
simple_landscape <- function(css = NULL, ...){
    pagedown::html_paged(css = c(pkg_resource("css", "simple_landscape.css"), css), template = pkg_resource("html", "template_simple.html"), ...)
}
