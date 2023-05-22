library(shiny)
library(shinyWidgets)

shinyUI(fluidPage(
    titlePanel("Height Prediction of Children by 'GaltonFamilies' dataset"),
    sidebarLayout(
        sidebarPanel(
            helpText("In this application, I predicted children's height on the basis of their gender, father & mother's height, and midparentHeight.
                     For more information on the dataset, go through - https://rdrr.io/cran/HistData/man/GaltonFamilies.html"),
            helpText("Choose the gender of the children, and Change the slider to adjust the height of father & mother:"),
            radioGroupButtons(inputId = "gender.kid",
                              label = "Gender of Children:",
                              choices = c("Male"="male", "Female"="female"),
                              status = c("male", "female"),
                              individual = T,
                              direction = "vertical"),
            tags$style(
                ".btn-male.active {background-color: #041D56; color: #ffffff;}",
                ".btn-female.active {background-color: #041D56; color: #ffffff;}"
            ),
            setSliderColor(c("#266CA9", "#0F2573"), c(1, 2)),
            sliderInput(inputId = "height.F",
                        label = "Height of Father (m):",
                        value = 1.50,
                        min = 1.50,
                        max = 2.00,
                        step = 0.005),
            sliderInput(inputId = "height.M",
                        label = "Height of Mother (m):",
                        value = 1.40,
                        min = 1.40,
                        max = 1.80,
                        step = 0.005)
        ),
        
        mainPanel(
            htmlOutput("pText"),
            plotOutput("Plot", width = "100%", height = "600px")
        )
    )
))
