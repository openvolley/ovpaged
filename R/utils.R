pkg_resource <- function(...) normalizePath(system.file("resources", ..., package = "ovpaged", mustWork = TRUE), mustWork = TRUE)
