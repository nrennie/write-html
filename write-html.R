# Read csv file -----------------------------------------------------------

input <- readr::read_csv("input.csv")

# Get input values --------------------------------------------------------

url <- input$url[1]
title <- input$title[1]
author <- input$author[1]
content <- input$content[1]


# Write html file ---------------------------------------------------------

write_html <- function(url, title, author, content) {
  # process url
  url <- gsub(" ", "-", url)
  url <- gsub("[^a-zA-Z0-9 -]","" , url ,ignore.case = TRUE)
  
  # create file
  fname <- paste0(url, ".html")
  file.create(fname)

  # create yaml
  yaml_input <- yaml::as.yaml(data.frame(
    title = title,
    author = author
  ))

  # create content
  content_input <- paste0(
    "<p>", content, "</p>"
  )

  # join together
  file_contents <- paste0(
    "---", "\n", yaml_input, "---",
    "\n", content_input
  )

  # write to file
  fileConn <- file(fname)
  writeLines(file_contents, fileConn)
  close(fileConn)
}

# check it works...
write_html(url, title, author, content)
