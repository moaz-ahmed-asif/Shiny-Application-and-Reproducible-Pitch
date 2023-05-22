library(shiny)

library(dplyr)
library(ggplot2)
library(HistData)
data(GaltonFamilies)

newGalton <- GaltonFamilies %>% mutate(father = 2.54 * father / 100,
                                       mother = 2.54 * mother / 100,
                                       midparent = 2.54 * midparentHeight / 100,
                                       child = 2.54 * childHeight / 100)

LM <- lm(child ~ father + mother + gender + midparent, newGalton)

shinyServer(function(input, output) {
    
    output$pText <- renderText({
        pred.DF <- data.frame(father = input$height.F,
                              mother = input$height.M,
                              gender = input$gender.kid,
                              midparent = (input$height.F + 1.08 * input$height.M) / 2)
        prediction <- predict(LM, pred.DF)
        children <- ifelse(input$gender.kid == "male", "Son", "Daugther")
        
        paste("<br>", "If the Father's height is ", round(input$height.F, 3), 
              "m, and Mother's height is ", round(input$height.M, 3),
              "m, then the ", children, "'s predicted height is ",
              round(prediction, 3), " m.")
    })
    
    output$Plot <- renderPlot({
        children <- ifelse(input$gender.kid == "male", "Son", "Daugther")
        pred.DF <- data.frame(father = input$height.F,
                              mother = input$height.M,
                              gender = input$gender.kid,
                              midparent = (input$height.F + 1.08 * input$height.M) / 2)
        prediction <- predict(LM, pred.DF)
        ys <- c("Father", "Mother", children)
        DF <- data.frame(
            x = factor(ys, levels = ys),
            y = c(input$height.F, input$height.M, prediction))
        ggplot(DF, aes(x, y)) +
            geom_bar(stat = "identity", color = c("#266CA9", "#0F2573", "#041D56"), fill = c("#266CA9", "#0F2573", "#041D56"), width = 0.70) +
            xlab("") +
            ylab("Height (m)") +
            theme(axis.text = element_text(size = 13, color = "black"), axis.title = element_text(size = 13))
    })
})