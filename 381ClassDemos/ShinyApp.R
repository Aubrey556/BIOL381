# Shiny App
#Nov 28, 2018
#AMP

# ShinyApp is an r package that builds interactive web apps
# uses R coding and web interactiveness to create a reactive experience
#ui - user interface: controls appearance of the app
# server - the coding instructions for the shiny app
# control widgets: web elements that users interact with

library(shiny)

# Define ui -
ui <- fluidPage(
  titlePanel(""),
  sidebarLayout(
    sidebarPanel(
    ),
    mainPanel(
    )
  )
)


# Define server
server <- function(input, output){}

# run the app
shinyApp (ui=ui, server=server)

ui <- fluidPage(
  
  #add a title
  titlePanel("This is a test shiny"),
  #create sidebar
  sidebarLayout(position = "right",
                sidebarPanel(
                  # add a header in side panel
                  h1("this is my first header"), 
                  h2("second"),
                  h3("third"),
                  selectInput("X", label= "X", names(trees)),
                  selectInput("Y", label = "Y", names(trees))),
                mainPanel(
                  # add a header
                  h1("header"),
                  strong("this is important text"),
                  # add a paragraph
                  p("This is a paragraph about my graph"),
                  br(),
                  #add in an image
                  img(src = "Bandicoot_Pouch_Young.jpg", height = 75, width = 75),
                  plotOutput("TreePlot")
                )
  )
)


server <- function(input, output){
  selectedData <- reactive({
    trees[,c(input$X, input$Y)]
  })
  
  # use render plot to add reactive element to your plot
  output$TreePlot <- renderPlot({
    
    # basic plot function that's built into R
    plot(selectedData(),
         type = "p",
         
         # change point: pch values stored plto: 31.25 = color and fill points, 19 - points
         pch = 21.25,
         col = "black",
         bg = "blue",
         
         # add a main title to graph
         main="this is the title",
         
         # subtitle
         sub = "This is a good place to put a caption")
  }
  )
}

#call to shiny app
shinyApp(ui=ui, server=server)
