library(shinydashboard)
library(shiny)

ui <- dashboardPage(skin = "green",
  dashboardHeader(title = "大家都在买"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("点击效果", tabName = "点击效果", icon = icon("dashboard")),
      menuItem("类目召回率", tabName = "类目召回率", icon = icon("dashboard")),
      menuItem("明细数据", tabName = "明细数据", icon = icon("th")),
      menuItem("人群差异", tabName = "人群差异", icon = icon("th")),
      menuItem("叶子分析", tabName = "叶子分析", icon = icon("th"))
      )
  ),
  
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "点击效果",
              fluidRow(width = 12, 
                box(width = 8, plotOutput("add2cartRatePlot")),
                box(width = 4,
                  title = "select", background = "black",
                  dateRangeInput("dates_range",
                                 start  = "2015-05-20",
                                 end = Sys.Date() -1,
                                 label = h3("日期范围")),
                  selectInput("selectStat", label = h3("选择指标"), 
                              choices = list("加购率" = "加购率", 
                                             "平均加购金额" = "平均加购金额",
                                             "点击率" = "点击率",
                                             "订单用户占比" = "订单用户占比",
                                             "点击uv" = "click_uv", 
                                             "订单转换率" = "订单转换率",
                                             "uv" = "uv",
                                             "加购买家数" = "add2cart_uv",
                                             "加购支付买家数" = "ords",
                                             "无线非生鲜下单用户数"="total_ords"
                              ), 
                              selected = "加购率"))               
                )      
      ),
      # Second tab content
      tabItem(tabName = "类目召回率",
              box(width = 8, plotOutput("recallPlot"))
              ),
      tabItem(tabName = "明细数据",
              box(width = 12, DT::dataTableOutput('datashow'))),
      tabItem(tabName = "人群差异",
              box( width = 12, DT::dataTableOutput('group_datashow'))),
      tabItem(tabName = "叶子分析",
              box( width = 12, DT::dataTableOutput('cate_datashow')))      
    )
  )
)
