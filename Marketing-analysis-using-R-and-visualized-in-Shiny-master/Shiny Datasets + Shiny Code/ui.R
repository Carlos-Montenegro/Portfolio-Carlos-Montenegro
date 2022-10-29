#install.packages("shiny")
#library(shiny)
#setwd("D:/User/Google Drive/Proyectos/Estudios/Courses/8. Business Analytical Tool - Open Sources/Open Source - Shared folder/Source/firstShinyApp")
#runApp()

#Start the structure of th shiny application
shinyServer(
  #We will create a page with a sidebar
  pageWithSidebar(
    #we are including titles
    headerPanel('Shiny Application - Internet Sports Gambling Activity'),
    sidebarPanel(
      #Here we specify the options of the dropdown
      selectInput("Product",
                  "Please Select Product Type",
                  choices=c("Sports book fixed-odd",
                            "Sports book live-action",
                            "Poker BossMedia",
                            "Casino BossMedia",
                            "Supertoto",
                            "Games VS",
                            "Games bwin",
                            "Casino Chartwell"))
      ),
    mainPanel(
      tabsetPanel(
        #here we specify the location of the plots
        tabPanel("Distribution of users","In this section you can explore the distribution of the number of people in each country, age and country. You can interact with the side bar to have the view of other product types.",
                 plotOutput("myPlot1"),
                 plotOutput("myPlot2"),
                 plotOutput("myPlot3")),
        tabPanel("Relationships","In this section you can explore the relationships between the gains of the users and the number of games, age and oldness in the company. You can interact with the side bar to have the view of other product types.",
                 plotOutput("ScatPlot1"),
                 plotOutput("ScatPlot2"),
                 plotOutput("ScatPlot3"))
          
      )
    )
  )
)



