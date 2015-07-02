library(shinydashboard)
library(shiny)

server <- function(input, output) {
  ### 清洗数据，选择日期
  clean_data <- function(data, date_range){
    ### 去除其他地区的
    data = data[data["站点"] !="其他", ]
    data$日期 = as.Date(data$日期, format="%Y%m%d")
    
    start = input$dates_range[1]
    date_end = input$dates_range[2]
    selectdf = data[ data$日期 >= start & data$日期 <= date_end, ]
    selectdf
  }
  ### 增加指标
  stat_data <- function(data){ 
    g = group_by(data, 日期)
    res = summarise(g, 
                    uv = sum(uv), 
                    click_uv = sum(点击uv),
                    add2cart_uv = sum(加购买家数), 
                    add2cart_amt = sum(加购支付金额),
                    ords = sum(加购支付买家数),
                    total_ords = sum(无线非生鲜下单用户数)
    )  
    
    res["加购率"] = res["add2cart_uv"] / res["uv"]    
    res["订单转换率"] = res["ords"] / res["add2cart_uv"]
    res["平均加购金额"] = res["add2cart_amt"] / res["uv"]      
    res["点击率"] = res["click_uv"] / res["uv"] 
    res["订单用户占比"] = res["ords"] / res["total_ords"]     
    res["show_stat"] = res[input$selectStat]  
    res
  }
  
  output$add2cartRatePlot <- renderPlot({
    
    selectdf = clean_data(data, input$dates_range)   
    res = stat_data(selectdf)
    
    ggplot(res, aes(x=日期, y = show_stat ) ) + 
      geom_point(colour = 'red', size = 3) + geom_line(colour = "blue", size = 2)  + labs(x="date", y = NULL, family="Kaiti")
    
  })

  output$recallPlot <- renderPlot({
    recall_data[,'recall@N'] = sapply(strsplit(recall_data$typ,'@'), function(x) as.integer(x[2]))
    ggplot(recall_data, aes(x=`recall@N`, y = recall ) ) + 
      geom_point(colour = 'red', size = 3) + geom_line(colour = "blue", size = 2)  + labs(y="score")
  })
  
    
  #output$datashow <- renderDataTable({
  #  data
  #},options = list(aLengthMenu = c(5, 30, 50), iDisplayLength = 5))
  output$datashow <- DT::renderDataTable(
    data, options = list(initComplete = JS(
                          "function(settings, json) {",
                          "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                          "}")))
  
  output$group_datashow <- DT::renderDataTable(
    group_report, options = list(lengthChange = FALSE,
                                 initComplete = JS(
                                  "function(settings, json) {",
                                  "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                                  "}")))
  
  output$cate_datashow <- DT::renderDataTable(
    recAnalysis, options = list(lengthChange = FALSE,
                                 initComplete = JS(
                                   "function(settings, json) {",
                                   "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                                   "}"))) 
}

