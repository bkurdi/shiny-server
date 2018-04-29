if (!require(shiny)) {install.packages("shiny"); require(shiny)}
if (!require(car)) {install.packages("car"); require(car)}
if (!require(shinythemes)) {install.packages("shinythemes"); require(shinythemes)}
if (!require(shinyapps)) {install.packages("shinyapps"); require(shinyapps)}

function(input, output) {
     output$scatter <- renderPlot({ 
          plot(ratings$Valence_mean[ratings$Category %in% input$theme],
               ratings$Arousal_mean[ratings$Category %in% input$theme],
               xlab = "Valence", ylab = "Arousal",
               xlim = c(1, 7), ylim = c(1,7), col = colvector[ratings$Category %in% input$theme], cex.lab = 1.4,
               )},
          height = 500, width = 500
     )
     minDist <- reactive({ 
                    if(is.null(input$plot_click$x)) 256
                    else {
                    i <- NULL
                    xydist <- vector()
                    for (i in 1:length(ratings$Valence_mean)) {
                    xydist[i] <- dist(rbind(c(input$plot_click$x, input$plot_click$y),
                    c(ratings$Valence_mean[i],
                      ratings$Arousal_mean[i])))
                    }
                    if (min(xydist) < 0.1 & ratings$Category[which.min(xydist)] %in% input$theme) which.min(xydist)
                    }
     })
     output$info <- renderText({
          paste0("ID number: ", ratings$ID[minDist()], "\nValence mean: ", round(ratings$Valence_mean[minDist()], 3),
                 "\nValence SD: ", round(ratings$Valence_SD[minDist()], 3), "\nArousal mean: ", round(ratings$Arousal_mean[minDist()], 3),
                 "\nArousal SD: ", round(ratings$Arousal_SD[minDist()], 3))
     })
     output$selectedImage <- renderImage({
          filename <- normalizePath(file.path("./images", paste(ratings$Theme[minDist()], ".jpg", sep = "")))
          list(src = filename, alt = paste(ratings$Theme[minDist()]), width = 225)
     } , deleteFile = FALSE)
}