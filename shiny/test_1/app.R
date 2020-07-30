library(shiny)

ui <- 
    #navbarPage(title="Principales funciones y sus derivadas. Diego López. Colmex",
    fluidPage(
        #theme = "bootswatch-cerulean.css",
    titlePanel("Funciones y sus derivadas"),
    tabsetPanel(
            tabPanel("Logarítmica",
                sidebarLayout(position = "right",
                sidebarPanel(
                    tags$img(height=50,width=50,src="colmex.jpg"),
                    tags$hr(),
                    tags$p(strong("Diego Alberto López Tamayo")),
                    tags$p("Encuentra más herramientas en mi sitio"),
                    tags$a(href="https://diego-eco.github.io/", "Diego-eco"),
                    HTML("<h2>Parámetros</h2>"), #Podemos usar HTML puro
                    sliderInput(inputId = "num_1", 
                                         label = "Valor de X", 
                                         value = 5, min = 0.4, max = 20),
                             actionButton(inputId = "go",label = "Actualizar")
                             ),
                mainPanel(
                        h3("Función logarítmica de la forma y=log(x)"),
                        splitLayout(plotOutput("primitiva_1"),
                                    plotOutput("primera_1")),
                        splitLayout(plotOutput("segunda_1"),
                                    plotOutput("tercera_1")),
                          )
                        ) #End sidebarLayout 1
                ), #End tabPanel logarítmica
            
        tabPanel("Exponencial",
                 sidebarLayout(position = "right",
                       sidebarPanel(
                           tags$img(height=50,width=50,src="colmex.jpg"),
                           tags$hr(),
                           tags$p(strong("Diego Alberto López Tamayo")),
                           tags$p("Encuentra más herramientas en mi sitio"),
                           tags$a(href="https://diego-eco.github.io/", "Diego-eco"),
                           HTML("<h2>Parámetros</h2>"), #Podemos usar HTML puro
                           sliderInput(inputId = "num_2", 
                                       label = "Valor de X", 
                                       value = 0.5, min = 0.555, max = 3.55),
                           actionButton(inputId = "go",label = "Actualizar")
                       ),
                       mainPanel(
                           h3("Función exponencial de la forma y=x^(x)"),
                           splitLayout(plotOutput("primitiva_2"),
                                       plotOutput("primera_2")),
                           splitLayout(plotOutput("segunda_2"),
                                       plotOutput("tercera_2")),
                               )
                        ) #End sidebarLayout 2
                 ) #End tabPanel Exponencial
                ) # End tabsetPanel 
#) # end navbarPage
        ) # End fluidPage

server <- function(input, output) {
    x_1 <- reactive({
        seq(0.1,input$num_1,0.1) #reactive expression 
    })
    x_2 <- reactive({
        seq(0.1,input$num_2,0.1) #reactive expression 
    })
    observeEvent(input$go,{
        print(input$go)
    })
    #x <- eventReactive(input$go, {
    #    seq(input$num_1) # Button Event Reactive expression 
    #})
    output$primitiva_1 <- renderPlot({
        plot(x_1(),log(x_1()),type = "l",main = "Función Logarítmo",lwd=3,col=1)
    })
    output$primera_1 <- renderPlot({
        plot(x_1(),1/(x_1()),type = "l",main = "Primer derivada",lwd=3,col=3)
    })
    output$segunda_1 <- renderPlot({
        plot(x_1(),-1/(x_1()^2),type = "l",main = "Segunda derivada",lwd=3,col=4)
    })
    output$tercera_1 <- renderPlot({
        plot(x_1(),2/(x_1()^3),type = "l",main = "Tercer derivada",lwd=3,col=6)
    })
    output$primitiva_2 <- renderPlot({
        plot(x_2(),x_2()^(x_2()),type = "l",main = "Función Exponencial",lwd=3,col=1)
    })
    output$primera_2 <- renderPlot({
        plot(x_2(),x_2()^(x_2())*(1+log(x_2())),type = "l",main = "Primer derivada",lwd=3,col=3)
    })
    output$segunda_2 <- renderPlot({
        plot(x_2(),x_2()^(x_2())*((1/x_2())+(1+log(x_2()))^2),type = "l",main = "Segunda derivada",lwd=3,col=4)
    })
    output$tercera_2 <- renderPlot({
        plot(x_2(),
             x_2()^(-2 + x_2())*(-1 + 3*x_2() + x_2()^2 + 3*x_2()*(1 + x_2())*log(x_2()) +3*x_2()^2*log(x_2())^2 + x_2()^2*log(x_2())^2),
             type = "l",main = "Tercer derivada",lwd=3,col=6)
    })
}

shinyApp(ui = ui, server = server)