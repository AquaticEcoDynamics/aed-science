library(plotly)
library(dplyr)

#case 1
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

#case 4
case4 <- data.frame(
  par_c = double(),
  I_K = double(),
  fI = double()
)
for(i in seq(10, 500, by = 10)){
  case4_temp <- data.frame(
    par_c = seq(0, 2000, by = 10),
    I_K = i
  )
  case4_temp$fI <- tanh(case4_temp$par_c/case4_temp$I_K)
  case4 <- bind_rows(case4,case4_temp)
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
  case1,
  name="Case 1",
  x = case1$par_c, 
  y = case1$fI, 
  #frame = case1$I_K, 
  hovertemplate = 'fI: %{y:.2f}<extra></extra>',
  type = 'scatter',
  mode = 'lines')
fig <- fig %>% add_trace(
  case3,
  name="Case 3",
  x = case3$par_c, 
  y = case3$fI, 
  #frame = case3$I_K, 
  hovertemplate = 'fI: %{y:.2f}<extra></extra>',
  type = 'scatter',
  mode = 'lines')
fig <- fig %>% add_trace(
  case4,
  name="Case 4",
  x = case4$par_c, 
  y = case4$fI, 
  #frame = case4$I_K, 
  hovertemplate = 'fI: %{y:.2f}<extra></extra>',
  type = 'scatter',
  mode = 'lines')

fig <- fig %>%
  layout(
    hovermode = "x unified",
    xaxis = list(title='PAR C',hoverformat = "PAR C"), 
    yaxis = list(title='Light limitation (fI)'),
    sliders = list(active = 2, 
                   currentvalue = list(prefix = "Test: "), 
                   pad = list(t = 10), 
                   
                   steps = list(1:10)))
  #   ) %>% 
  # animation_opts(
  #   250, easing = "linear", redraw = FALSE
  # ) %>% 
  # animation_slider(
  #   currentvalue = list(prefix = "I_K: ")
  # ) %>% 
  # config(displayModeBar = FALSE,
  #        displaylogo = FALSE)
fig    
