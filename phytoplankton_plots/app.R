
library(shiny)
library(ggplot2)
library(ggtext)
library(ggrepel)
library(grid)
library(latex2exp)


ui <- fluidPage(
  plotOutput("casePlot"),
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #e41a1c;border-top: 1px solid #e41a1c;border-bottom: 1px solid #e41a1c;}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: #377eb8;border-top: 1px solid #377eb8;border-bottom: 1px solid #377eb8;}")),
  # tags$style(HTML(".js-irs-2 .irs-single, .js-irs-2 .irs-bar-edge, .js-irs-2 .irs-bar {background: green}")),
  fluidRow(
    column(6,
           sliderInput("ik_val", "I_K value:",
                       min = 10, max = 500, value = 250, step = 10, 
                       width = '100%', animate = TRUE
           )
    ),
    column(6,
           sliderInput("is_val", "I_S value:",
                       min = 10, max = 500, value = 250, step = 10, 
                       width = '100%', animate = TRUE
           )
    )
  )
)

server <- function(input, output) {
  
  par_c <- seq(0, 2000, by = 10)
  eps <- 0.5
  A  <- 5
  extc  <- 1
  dz  <- 1
  
  # CASE 1
  case1_fI <- reactive((par_c/input$ik_val)/(1+(par_c/input$ik_val)))  
  
  # CASE 2
  case2_fI <- reactive({
    x = par_c/input$is_val
    return(x * exp(1 - x))
  })
  
  # CASE 3
  case3_fI <- reactive((1 - exp(-(par_c/input$ik_val))))
  
  # CASE 4
  case4_fI <- reactive(tanh(par_c/input$ik_val))
  
  # CASE 5
  case5_fI <- reactive({
    x = par_c/input$ik_val
    return((exp(x*(1+eps))-1)/(exp(x*(1+eps))+1))
  })
  
  # CASE 6
  case6_fI <- reactive({
    x  <-  par_c/input$is_val
    fI  <-  ((2.0+A)*x)/(1+(A*x)+(x*x))
    return(fI)
  })
  
  # CASE 7
  # case7  <- reactive({
  #   fI  <- (exp(1-par_c/input$is_val)-exp(1-par_c/input$is_val))/(extc*dz)
  #   return(fI)
  # })
  
  # PLOT
  output$casePlot <- renderPlot({
    ggplot()+
      geom_line(mapping = aes(x=par_c, y = case1_fI(), colour = "Case 1", linetype = 'Case 1'), size = 1.25
      ) +
      geom_line(mapping = aes(x=par_c, y = case2_fI(), colour = "Case 2 (*Case 7)", linetype = 'Case 2 (*Case 7)'), size = 1.25
      ) +
      geom_line(mapping = aes(x=par_c, y = case3_fI(), colour = "Case 3 (*Case 0)", linetype = 'Case 3 (*Case 0)'), size = 1.25
      ) +
      geom_line(mapping = aes(x=par_c, y = case4_fI(), colour = "Case 4", linetype = 'Case 4'), size = 1.25
      ) +
      geom_line(mapping = aes(x=par_c, y = case5_fI(), colour = "Case 5", linetype = 'Case 5'), size = 1.25
      ) +
      geom_line(mapping = aes(x=par_c, y = case6_fI(), colour = "Case 6", linetype = 'Case 6'), size = 1.25
      ) + 
      scale_colour_manual(
        name='**Model approach**', 
        values = c("#e41a1c", "#377eb8", "#e41a1c", "#e41a1c", "#e41a1c", "#377eb8", "#377eb8"),
        labels = c('Case 1', 'Case 2 (*Case 7)', 'Case 3 (*Case 0)','Case 4','Case 5','Case 6','Case 7')) +
      scale_linetype_manual(
        name='**Model approach**', 
        values = c("solid", "solid", "dotted", "dashed", "twodash", "dashed", "dotted"),
        labels = c('Case 1', 'Case 2 (*Case 7)', 'Case 3 (*Case 0)','Case 4','Case 5','Case 6','Case 7')) +
      labs(x = TeX('Light ($PAR$)'), y = TeX("Photosynthesis $( \\Phi_{light}^{PHY}(I) )$"))+
      theme_light()+
      theme(
        plot.margin=unit(c(1,0,0,0),"cm"),
        axis.line = element_line(colour = 'black'),
        axis.ticks = element_line(colour = 'black'),
        axis.text = element_text(colour='black',size=15),
        axis.title = element_text(colour='black',size=16),
        legend.text = element_text(colour='black',size=15),
        legend.title = element_markdown(size=16),
        legend.background = element_blank(),
        legend.key.width = unit(1.5, "cm"),
        legend.justification = c("left", "top"),
        legend.box.just = "left",
        legend.direction="vertical",
        panel.border = element_blank(),
        plot.title = element_markdown(size=20)
      )
  })
}

# RUN
shinyApp(ui = ui, server = server)
