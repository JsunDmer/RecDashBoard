library('RODPS')
library(dplyr)
library(lubridate)
library(ggplot2)
library(shinydashboard)
library(shiny)
#library(metricsgraphics)
#library(htmlwidgets)
#library(htmltools)
library(DT)

data <- rodps.load.table('tmcs_jx_djdzm_Rec_report')
### 人群分析
group_report <- rodps.query("select * from tmcs_jx_djdzm_rec_group_report where ds >= '20150620'")

### 覆盖率数据
#recCoverRate <- rodps.query("select * from tmcs_jx_rec_item_coverRate where ds >= '20150620'")
### 推荐分析
#recAnalysis <- rodps.('tmcs_jxins_djdzm_add2cart_rec_price_stat')

recAnalysis <- rodps.query("select * from tmcs_jx_Rec_cate_ananlysis where ds >= '20150620'")

recall_data <-  rodps.query("select * from tmp_jx_order_user_recall") 









