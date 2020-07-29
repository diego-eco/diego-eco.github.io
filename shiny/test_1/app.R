library(shiny)

ui <- fluidPage(
    titlePanel("Prueba 1 Diego López función logarítmo y sus primeras dos derivadas"),
    sliderInput(inputId = "num", 
                label = "Valor de X", 
                value = 2, min = 1, max = 100),
    plotOutput("primitiva"),
    plotOutput("primer"),
    plotOutput("segunda")
)

server <- function(input, output) {
    output$primitiva <- renderPlot({
        plot(seq(input$num),log(seq(input$num)),type = "o",main = "Función Logarítmo")
    })
    output$primer <- renderPlot({
        plot(seq(input$num),1/(seq(input$num)),type = "o",main = "Primer derivada")
    })
    output$segunda <- renderPlot({
        plot(seq(input$num),-1/(seq(input$num)^2),type = "o",main = "Segunda derivada")
    })
}

shinyApp(ui = ui, server = server)