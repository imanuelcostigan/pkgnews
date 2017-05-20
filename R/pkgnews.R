#' Access package news files
#'
#' R package NEWS files are named `NEWS` but can have three particular formats:
#' plain text files with no file extension; plain text markdown files with the
#' extension `.md` (i.e. `NEWS.md`); or R documentation files with the extension
#' `.Rd`. The last format is very rare. While it is reasonably simple to access
#' the first two types of file (e.g. call to `news(package = "curl")`), getting
#' access to the `NEWS.md` file is a bit more verbose. This function makes
#' this more parsimonious and allows you to access the package's Github release
#' pages where none of these are available.
#'
#'
#' @param pkg the name of the package
#' @param gh_release flag whether or not to source the NEWS file from the local R
#'   library or whether to try to direct you to the Github releases page if the
#'   Github URL is available in the package's `DESCRIPTION` file (default:
#'   `FALSE`).
#' @return a call to `[utils::browseURL()]` to open the NEWS file or an
#'   appropriate error message if this fails
#' @examples
#' \dontrun{
#' show_pkg_news("curl")  # NEWS
#' show_pkg_news("Rcpp")  # NEWS.Rd
#' show_pkg_news("readr") # NEWS.md
#' }
#' @export

show_pkg_news <- function(pkg, gh_release = FALSE) {
  if (gh_release) {
    show_gh_releases(pkg)
  } else {
    show_local_pkg_news(pkg)
  }
}


show_local_pkg_news <- function(pkg) {
  n <- utils::news(package = pkg)
  if (is.null(n)) {
    pkg_dir <- system.file(package = pkg, mustWork = TRUE)
    news_files <- list.files(pkg_dir,
      pattern = "NEWS\\.md|markdown", full.names = TRUE)
    if (length(news_files) == 0) {
      stop("There is no NEWS.md file in ", pkg, call. = FALSE)
    } else {
      out_file <- tempfile(fileext = ".html")
      markdown::markdownToHTML(news_files[1], output = out_file)
    }
    utils::browseURL(out_file)
  } else {
    n
  }
}

gh_url <- function(pkg) {
  pkg_dir <- system.file(package = pkg, mustWork = TRUE)
  urls <- desc::desc_get_urls(file.path(pkg_dir, "DESCRIPTION"))
  urls[grepl("github\\.com", urls)][1]
}

show_gh_releases <- function(pkg) {
  repo_url <- gh_url(pkg)
  if (is.na(repo_url)) {
    stop("Remote URL not found", call. = FALSE)
  } else {
    # Assume that package URL is correct given CRAN checks
    # Clean up URL stubs e.g. "https://github.com/jeroen/curl#readme"
    clean_url <- sub("(github.com/[\\w\\-]+/[\\w\\-]+)[[:punct:]]\\w+", "\\1",
      repo_url, perl = TRUE)
    utils::browseURL(paste0(clean_url, "/releases"))
  }
}