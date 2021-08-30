library(knitr)
library(kableExtra)
library(readxl)
library(rmarkdown)
carbon <- read_excel('tables/carbonTableNewGrouping.xlsx', sheet = 3)
carbon <- carbon[carbon$Table == "Diagnostics",]
carbonGroups <- unique(carbon$Group)
carbon$`AED name` <- paste0("`",carbon$`AED name`,"`")

for(i in seq_along(carbon$Symbol)){
  if(!is.na(carbon$Symbol[i])==TRUE){
    carbon$Symbol[i] <- paste0("$$",carbon$Symbol[i],"$$")
  } else {
    carbon$Symbol[i] <- NA
  }
}

kbl(carbon[,3:NCOL(carbon)], caption = "Carbon - diagnostics", align = "l",) %>%
  pack_rows(carbonGroups[1],
            min(which(carbon$Group == carbonGroups[1])),
            max(which(carbon$Group == carbonGroups[1])),
            background = '#ebebeb') %>%
  pack_rows(carbonGroups[2],
            min(which(carbon$Group == carbonGroups[2])),
            max(which(carbon$Group == carbonGroups[2])),
            background = '#ebebeb') %>%
  row_spec(0, background = "#14759e", bold = TRUE, color = "white") %>%
  kable_styling(full_width = F,font_size = 12) %>%
  scroll_box(width = "770px", height = "500px",
             fixed_thead = FALSE)
