library(readxl)
library(kableExtra)
library(rmarkdown)
carbon <- read_excel('tables/carbonTable.xlsx', sheet = 3)
carbonGroups <- unique(carbon$Group)
carbon$`AED name` <- paste0("`",carbon$`AED name`,"`")

for(i in seq_along(carbon$Symbol)){
  if(!is.na(carbon$Symbol[i])==TRUE){
    carbon$Symbol[i] <- paste0("$$",carbon$Symbol[i],"$$")
  } else {
    carbon$Symbol[i] <- NA
  }
}

kbl(carbon[,2:8], caption = "Carbon table") %>%
  kable_paper("striped", full_width = F) %>%
  pack_rows(carbonGroups[1], 
            min(which(carbon$Group == carbonGroups[1])), 
            max(which(carbon$Group == carbonGroups[1]))) %>% 
  pack_rows(carbonGroups[2], 
            min(which(carbon$Group == carbonGroups[2])), 
            max(which(carbon$Group == carbonGroups[2]))) %>% 
  pack_rows(carbonGroups[3], 
            min(which(carbon$Group == carbonGroups[3])), 
            max(which(carbon$Group == carbonGroups[3]))) %>% 
  row_spec(0, background = "#14759e", bold = TRUE, color = "white") %>% 
  kable_styling(full_width = F)



library(knitr)
library(kableExtra)
library(readxl)
library(rmarkdown)
carbon <- read_excel('tables/carbonTable.xlsx', sheet = 3)
carbonGroups <- unique(carbon$Group)
carbon$`AED name` <- paste0("`",carbon$`AED name`,"`")

for(i in seq_along(carbon$Symbol)){
  if(!is.na(carbon$Symbol[i])==TRUE){
    carbon$Symbol[i] <- paste0("$$",carbon$Symbol[i],"$$")
  } else {
    carbon$Symbol[i] <- NA
  }
}

kbl(carbon[,2:8], caption = "Carbon table", align = "l",) %>%
  pack_rows(carbonGroups[1], 
            min(which(carbon$Group == carbonGroups[1])), 
            max(which(carbon$Group == carbonGroups[1])),
            background = '#ebebeb') %>% 
  pack_rows(carbonGroups[2], 
            min(which(carbon$Group == carbonGroups[2])), 
            max(which(carbon$Group == carbonGroups[2])),
            background = '#ebebeb') %>% 
  pack_rows(carbonGroups[3], 
            min(which(carbon$Group == carbonGroups[3])), 
            max(which(carbon$Group == carbonGroups[3])),
            background = '#ebebeb') %>% 
  row_spec(0, background = "#14759e", bold = TRUE, color = "white") %>% 
  kable_styling(full_width = F,font_size = 12) %>% 
  scroll_box(width = "770px", height = "500px",
             fixed_thead = FALSE) 
