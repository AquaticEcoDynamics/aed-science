
library(shiny)
library(ggplot2)
library(ggtext)
ui <- fluidPage(
        plotOutput("casePlot"),
        sliderInput("ik_val", "I_K value:",
                    min = 10, max = 500, value = 10, step = 10, width = '100%', animate = TRUE
        ),
        sliderInput("is_val", "I_S value:",
                    min = 10, max = 500, value = 10, step = 10, width = '100%', animate = TRUE
        ),
)


server <- function(input, output) {
    
    par_c <- seq(0, 2000, by = 10)
    
    case3_fI <- reactive((1 - exp(-(par_c/input$ik_val))))
    case4_fI <- reactive(tanh(par_c/input$ik_val))
    case1_fI <- reactive((par_c/input$ik_val)/(1+(par_c/input$ik_val)))  
    case6_fI <- reactive(
        ((2+5)*(par_c/input$is_val))/(1+(5*(par_c/input$is_val)+((par_c/input$is_val)*(par_c/input$is_val))))
    )

    output$casePlot <- renderPlot({
        ggplot()+
            geom_line(mapping = aes(x=par_c, y = case1_fI(), colour = 'Case 1')) +
            geom_line(mapping = aes(x=par_c, y = case3_fI(), colour = 'Case 3')) +
            geom_line(mapping = aes(x=par_c, y = case4_fI(), colour = 'Case 4')) +
            geom_line(mapping = aes(x=par_c, y = case6_fI(), colour = 'Case 6')) +
            labs(x = 'Light (PAR)', y = 'Photosynthesis (fI)')+
            ggtitle('**Light limitation of pytoplankton**')+
            theme_light()+
            theme(
                axis.line = element_line(colour = 'black'),
                axis.ticks = element_line(colour = 'black'),
                axis.text = element_text(colour='black'),
                legend.title = element_blank(),
                legend.background = element_blank(),
               # legend.position = c('top'),
                legend.position = c(1, 1.075),
                legend.justification = c("right", "top"),
                legend.box.just = "right",
                legend.direction="horizontal",
                panel.border = element_blank(),
                plot.title = element_markdown()
            )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
