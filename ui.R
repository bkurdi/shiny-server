if (!require(shiny)) {install.packages("shiny"); require(shiny)}
if (!require(car)) {install.packages("car"); require(car)}
if (!require(shinythemes)) {install.packages("shinythemes"); require(shinythemes)}
if (!require(shinyapps)) {install.packages("shinyapps"); require(shinyapps)}

ratings <- read.csv("OASIS.csv", header = TRUE, sep = ",")
colnames(ratings)[1] <- "ID"
colvector <- recode(ratings$Category, "'Animal'='#008000'; 'Object'='#0000FF'; 'Person'='#FF0000'; 'Scenery'='#FFA500'")
colvector <- paste(colvector)

fluidPage(
     theme = shinytheme("readable"),
     tags$style(type='text/css', '#info {font-family: Georgia, serif;}'), 
     h1("OASIS valence and arousal ratings"),
     p("Use the checkbox to restrict the valence and arousal ratings displayed to one or more image categories."),
     p("In order to display an image, along with its ID and ratings, click on the appropriate point in the scatterplot."),
     fluidRow(
     column(3, checkboxGroupInput(inputId = "theme", label = "Theme", choices = c("Animal" = "Animal", "Object" = "Object",
     "Person" = "Person", "Scenery" = "Scenery"), selected = c("Animal", "Object", "Person", "Scenery")),
     verbatimTextOutput("info"),
     imageOutput("selectedImage")),
     column(9, plotOutput("scatter", click = "plot_click")))
)