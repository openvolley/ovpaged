#' Simple paged report template
#'
#' @param css string: additional css
#' @param orientation string: "portrait" or "landscape" (experimental)
#' @param autolink_bare_uris logical: if `TRUE`, convert absolute URIs into links, even when not surrounded by pointy braces `<...>`. It is set to `FALSE` by default here so that the `header-image` parameter in the document YAML is not converted. This is equivalent to specifying `md_extensions: -autolink_bare_uris` in the document YAML directly
#' @param striped logical: if `TRUE`, include css that makes table rows striped
#' @param auto_table_breaks logical: if `TRUE`, automatically break tables across pages
#' @param hide_page_numbers logical: if `TRUE`, hide page numbers
#' @param ... : passed to [pagedown::html_paged()]
#'
#' @return A pagedown template
#' @export
simple <- function(css = NULL, orientation = "portrait", autolink_bare_uris = FALSE, striped = TRUE, auto_table_breaks = TRUE, hide_page_numbers = FALSE, ...){
    orientation <- match.arg(orientation, c("portrait", "landscape"))
    rgs <- list(...)
    if (!isTRUE(autolink_bare_uris)) rgs$md_extensions <- paste0(rgs$md_extensions, "-autolink_bare_uris")
    rgs$css <- pkg_resource("css", paste0("simple_", orientation, ".css"))
    ##if ("bootstrap_grid" %in% opts) {
    ##    rgs$css <- c(rgs$css, pkg_resource("css", "bootstrap-grid.min.css"))
    ##}
    if (isTRUE(striped)) {
        rgs$css <- c(rgs$css, pkg_resource("css", "striped.css"))
    }
    if (isTRUE(auto_table_breaks)) {
        rgs$pandoc_args <- c(rgs$pandoc_args, "--variable=auto-table-breaks:true")
    }
    if (isTRUE(hide_page_numbers)) {
        rgs$pandoc_args <- c(rgs$pandoc_args, "--variable=no-page-numbers:true")
    }
    rgs$css <- c(rgs$css, css)
    rgs$template <- pkg_resource("html", "template_simple.html")
    do.call(pagedown::html_paged, rgs)
}

#' @rdname simple
#' @export
plain <- function(css = NULL, autolink_bare_uris = FALSE, striped = TRUE, auto_table_breaks = TRUE, ...){
    rgs <- list(...)
    if (!isTRUE(autolink_bare_uris)) rgs$md_extensions <- paste0(rgs$md_extensions, "-autolink_bare_uris")
    rgs$css <- pkg_resource("css", "plain.css")
    if (isTRUE(striped)) {
        rgs$css <- c(rgs$css, pkg_resource("css", "striped.css"))
    }
    if (isTRUE(auto_table_breaks)) {
        rgs$pandoc_args <- c(rgs$pandoc_args, "--variable=auto-table-breaks:true")
    }
    rgs$css <- c(rgs$css, css)
    rgs$template <- pkg_resource("html", "template_simple.html")
    do.call(pagedown::html_paged, rgs)
}

# * "bootstrap_grid" - include the css necessary for bootstrap grid layout, which means that you can use e.g. [shiny::fluidRow()] and [shiny::column()]. This does not include the bootstrap css styling, just the layout (css taken from <https://github.com/dmhendricks/bootstrap-grid-css> under the Bootstrap MIT license)

#' Posterdown HTML format (using pagedown::poster_relaxed)
#'
#' @param ... Additional arguments to [pagedown::poster_relaxed()]
#' @param template string: as for [pagedown::html_paged()]
#' @param css string: additional css
#'
#' @return R Markdown output format to pass to
#'   [rmarkdown::render()]
#'
#' @examples
#'  \donttest{
#'  myfile <- file.path(tempdir(), "foo.rmd")
#'  rmarkdown::draft(myfile, template = "poster", package = "ovpaged")
#' }
#'
#' @export
poster <- function(..., template = pkg_resource("html", "template_poster.html"), css = NULL) {
    pagedown::poster_relaxed(..., css = css, template = template)
}
