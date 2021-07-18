#' Simple paged report template
#'
#' @param css string: additional css
#' @param autolink_bare_uris logical: if `TRUE`, convert absolute URIs into links, even when not surrounded by pointy braces `<...>`. It is set to `FALSE` by default here so that the `header-image` parameter in the document YAML is not converted. This is equivalent to specifying `md_extensions: -autolink_bare_uris` in the document YAML directly
#' @param ... : passed to [pagedown::html_paged()]
#'
#' @return A pagedown template
#' @export
simple <- function(css = NULL, autolink_bare_uris = FALSE, ...){
    rgs <- list(...)
    if (!isTRUE(autolink_bare_uris)) rgs$md_extensions <- paste0(rgs$md_extensions, "-autolink_bare_uris")
    rgs$css <- c(pkg_resource("css", "style_simple.css"), css)
    rgs$template <- pkg_resource("html", "template_simple.html")
    do.call(pagedown::html_paged, rgs)
}

#' @rdname simple
#' @export
simple_landscape <- function(css = NULL, autolink_bare_uris = FALSE, ...){
    rgs <- list(...)
    if (!isTRUE(autolink_bare_uris)) rgs$md_extensions <- paste0(rgs$md_extensions, "-autolink_bare_uris")
    rgs$css <- c(pkg_resource("css", "simple_landscape.css"), css)
    rgs$template <- pkg_resource("html", "template_simple.html")
    do.call(pagedown::html_paged, rgs)
}
