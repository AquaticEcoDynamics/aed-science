<center>
  
  ```{r nitrogen-1, echo=FALSE, fig.cap="Summary of two main reactions in the default nitrogen model.", out.width = '40%'}
library(visNetwork)
library(magrittr)


path_to_images <- "images/12-nitrogen/network/"


nodes <- data.frame(
  id = 1:5, 
  # group = c("Core variables", "Linked variables", "Core variables", "Linked variables", "Linked variables"),
  #label = c('$+O_2$')
  shape = c("circularImage", "circularImage","circularImage", "circularImage", "circularImage"),
  image = c(paste0(path_to_images, 1:5, ".png"))
)

edges <- data.frame(
  from = c(1,2,3,4,5), 
  to = c(2,3,4,1,3),
  arrows = c('to','to','to','to', 'from'))

# default, on group
visNetwork(nodes, 
           edges, 
           # main = "A really simple example", 
           width = "100%") %>% 
  visNodes(
    shapeProperties = list(useBorderWithImage = TRUE),
    brokenImage="http://localhost/Images/erroe.png"
  )
# visGroups(groupname = "Core variables", color = "red", shape = "image") %>%
# visGroups(groupname = "Linked variables", color = "lightgrey") %>%
# visLegend()

#knitr::include_graphics("images/12-nitrogen/picture1.png")

```

</center>