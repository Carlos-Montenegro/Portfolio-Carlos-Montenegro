#Again, here we initialize the commands for the application
shinyServer(
function(input,output,session){
  #We call the data that we are going to use in the application
  datamart<-read.csv("datamart.csv")
  country_P1<-read.csv("country_P1.csv")
  country_P2<-read.csv("country_P2.csv")
  country_P3<-read.csv("country_P3.csv")
  country_P4<-read.csv("country_P4.csv")
  country_P5<-read.csv("country_P5.csv")
  country_P6<-read.csv("country_P6.csv")
  country_P7<-read.csv("country_P7.csv")
  country_P8<-read.csv("country_P8.csv")
  gender<-read.csv("gender.csv")
  age<-read.csv("age.csv")
  
  Product1<-"Sports book fixed-odd"
  Product2<-"Sports book live-action"
  Product3<-"Poker BossMedia"
  Product4<-"Casino BossMedia"
  Product5<-"Supertoto"
  Product6<-"Games VS"
  Product7<-"Games bwin"
  Product8<-"Casino Chartwell"
  
  #Each element created in output is going to help us to show the different plots we need in the shiny app
  #The first three plots will be used in the first tab of the shiny application and the last three in the second one.
  output$myPlot1<-renderPlot({
    ProdType<-input$Product
    #We need to create a set of ifs to change the content of the plot according to the product type selected
    if (ProdType==Product1) {
      country_P_Count<-country_P1$P1
      country_P_Country<-country_P1$CountryName
    } else if (ProdType==Product2){
      country_P_Count<-country_P2$P2
      country_P_Country<-country_P2$CountryName
    } else if (ProdType==Product3){
      country_P_Count<-country_P3$P3
      country_P_Country<-country_P3$CountryName
    } else if (ProdType==Product4){
      country_P_Count<-country_P4$P4
      country_P_Country<-country_P4$CountryName
    } else if (ProdType==Product5){
      country_P_Count<-country_P5$P5
      country_P_Country<-country_P5$CountryName
    } else if (ProdType==Product6){
      country_P_Count<-country_P6$P6
      country_P_Country<-country_P6$CountryName
    } else if (ProdType==Product7){
      country_P_Count<-country_P7$P7
      country_P_Country<-country_P7$CountryName
    } else {
      country_P_Count<-country_P8$P8
      country_P_Country<-country_P8$CountryName
    }
    barplot(country_P_Count,names.arg=country_P_Country,xlab="Country",ylab="Number of users",
            main="Number of users per country",las=2, border=0)

    
    
  })
  output$myPlot2<-renderPlot({
    ProdType<-input$Product
    if (ProdType==Product1) {
      gender_Count<-gender$P1
    } else if (ProdType==Product2){
      gender_Count<-gender$P2
    } else if (ProdType==Product3){
      gender_Count<-gender$P3
    } else if (ProdType==Product4){
      gender_Count<-gender$P4
    } else if (ProdType==Product5){
      gender_Count<-gender$P5
    } else if (ProdType==Product6){
      gender_Count<-gender$P6
    } else if (ProdType==Product7){
      gender_Count<-gender$P7
    } else {
      gender_Count<-gender$P8
    }
    barplot(gender_Count,names.arg=gender$Gender,xlab="Gender",ylab="Number of users",
            main="Number of users per gender", border=0)
  })

  

  output$myPlot3<-renderPlot({
    ProdType<-input$Product
    if (ProdType==Product1) {
      age_Count<-age$P1
    } else if (ProdType==Product2){
      age_Count<-age$P2
    } else if (ProdType==Product3){
      age_Count<-age$P3
    } else if (ProdType==Product4){
      age_Count<-age$P4
    } else if (ProdType==Product5){
      age_Count<-age$P5
    } else if (ProdType==Product6){
      age_Count<-age$P6
    } else if (ProdType==Product7){
      age_Count<-age$P7
    } else {
      age_Count<-age$P8
    }
    barplot(age_Count,names.arg=age$AGE,xlab="Age",ylab="Number of users",
            main="Number of users per age", border=0)
  }) 


  
  output$ScatPlot1<-renderPlot({
    ProdType<-input$Product
    if (ProdType==Product1) {
      Product_CountOfProduct<-datamart$Product_1_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product2){
      Product_CountOfProduct<-datamart$Product_2_CountOfProduct
      Product_GainPositive<-datamart$Product_2_GainPositive
    } else if (ProdType==Product3){
      Product_CountOfProduct<-datamart$Poker_BuyCount
      Product_GainPositive<-datamart$Poker_PositiveProfits
    } else if (ProdType==Product4){
      Product_CountOfProduct<-datamart$Product_4_CountOfProduct
      Product_GainPositive<-datamart$Product_4_GainPositive
    } else if (ProdType==Product5){
      Product_CountOfProduct<-datamart$Product_5_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product6){
      Product_CountOfProduct<-datamart$Product_6_CountOfProduct
      Product_GainPositive<-datamart$Product_6_GainPositive
    } else if (ProdType==Product7){
      Product_CountOfProduct<-datamart$Product_7_CountOfProduct
      Product_GainPositive<-datamart$Product_7_GainPositive
    } else {
      Product_CountOfProduct<-datamart$Product_8_CountOfProduct
      Product_GainPositive<-datamart$Product_8_GainPositive
    }
      attach(datamart)
      plot(Product_CountOfProduct,Product_GainPositive, main="Number of plays vs. Customer's Positive Profits",
           xlab="Number of plays ", ylab="Customer's Positive Profits")
    })
  
  
  
  output$ScatPlot2<-renderPlot({
    ProdType<-input$Product
    if (ProdType==Product1) {
      Product_CountOfProduct<-datamart$Product_1_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product2){
      Product_CountOfProduct<-datamart$Product_2_CountOfProduct
      Product_GainPositive<-datamart$Product_2_GainPositive
    } else if (ProdType==Product3){
      Product_CountOfProduct<-datamart$Poker_BuyCount
      Product_GainPositive<-datamart$Poker_PositiveProfits
    } else if (ProdType==Product4){
      Product_CountOfProduct<-datamart$Product_4_CountOfProduct
      Product_GainPositive<-datamart$Product_4_GainPositive
    } else if (ProdType==Product5){
      Product_CountOfProduct<-datamart$Product_5_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product6){
      Product_CountOfProduct<-datamart$Product_6_CountOfProduct
      Product_GainPositive<-datamart$Product_6_GainPositive
    } else if (ProdType==Product7){
      Product_CountOfProduct<-datamart$Product_7_CountOfProduct
      Product_GainPositive<-datamart$Product_7_GainPositive
    } else {
      Product_CountOfProduct<-datamart$Product_8_CountOfProduct
      Product_GainPositive<-datamart$Product_8_GainPositive
    }
      attach(datamart)
      plot(AGE,Product_GainPositive, main="Age vs. Customer's Positive Profits",
           xlab="Age", ylab="Customer's Positive Profits")
    }) 

  
  
  output$ScatPlot3<-renderPlot({
    ProdType<-input$Product
    if (ProdType==Product1) {
      Product_CountOfProduct<-datamart$Product_1_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product2){
      Product_CountOfProduct<-datamart$Product_2_CountOfProduct
      Product_GainPositive<-datamart$Product_2_GainPositive
    } else if (ProdType==Product3){
      Product_CountOfProduct<-datamart$Poker_BuyCount
      Product_GainPositive<-datamart$Poker_PositiveProfits
    } else if (ProdType==Product4){
      Product_CountOfProduct<-datamart$Product_4_CountOfProduct
      Product_GainPositive<-datamart$Product_4_GainPositive
    } else if (ProdType==Product5){
      Product_CountOfProduct<-datamart$Product_5_CountOfProduct
      Product_GainPositive<-datamart$Product_1_GainPositive
    } else if (ProdType==Product6){
      Product_CountOfProduct<-datamart$Product_6_CountOfProduct
      Product_GainPositive<-datamart$Product_6_GainPositive
    } else if (ProdType==Product7){
      Product_CountOfProduct<-datamart$Product_7_CountOfProduct
      Product_GainPositive<-datamart$Product_7_GainPositive
    } else {
      Product_CountOfProduct<-datamart$Product_8_CountOfProduct
      Product_GainPositive<-datamart$Product_8_GainPositive
    }
      attach(datamart)
      plot(OldCustomer,Product_GainPositive, main="Customer Registration Recency vs. Customer's Positive Profits",
           xlab="Customer Registration Recency", ylab="Customer's Positive Profits")
    })

}
)
