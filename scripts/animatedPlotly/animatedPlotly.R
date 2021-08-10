# They require PAR as a vector (x-axis) and then each equation has a parameter (I_K or I_S)
# 
# Could we try to do 2 or 3 of these (Case 1 and Case 3)?
#   
#   We would range PAR (par_c) on the x-axis from 0 to 2000.
# y-axis (fI) would be 0 – 1
# I_K would be on a slider from 10 - 500.
library(plotly)
library(dplyr)

#case 1
# x = par_c/I_K
# fI = (par_c/I_K) / (1 + (par_c/I_K))

case1 <- data.frame(
  par_c = double(),
  I_K = double(),
  fI = double()
)

for(i in seq(10, 500, by = 10)){
  case1_temp <- data.frame(
    par_c = seq(0, 2000, by = 10),
    I_K = i
  )
  case1_temp$fI <-  (case1_temp$par_c/case1_temp$I_K)/(1+(case1_temp$par_c/case1_temp$I_K))  
  case1 <- bind_rows(case1,case1_temp)
}



#case 3
case3 <- data.frame(
  par_c = double(),
  I_K = double(),
  fI = double()
)

for(i in seq(10, 500, by = 10)){
  case3_temp <- data.frame(
    par_c = seq(0, 2000, by = 10),
    I_K = i
  )
  case3_temp$fI <- 1 - exp(-(case3_temp$par_c/case3_temp$I_K))
  case3 <- bind_rows(case3,case3_temp)
}

#create plot
fig <- plot_ly()
fig <- fig %>% add_trace(
  case3,
  name="case3",
  x = case3$par_c, 
  y = case3$fI, 
  frame = case3$I_K, 
  type = 'scatter',
  mode = 'lines')
fig <- fig %>% add_trace(
  case1,
  name="case1",
  x = case1$par_c, 
  y = case1$fI, 
  frame = case1$I_K, 
  type = 'scatter',
  mode = 'lines')
fig <- fig %>%
  animation_opts(
    250, easing = "linear", redraw = FALSE
  ) %>% 
  config(displayModeBar = FALSE,
         displaylogo = FALSE)
fig    
