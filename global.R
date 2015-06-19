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
group_report <- rodps.load.table('tmcs_jx_djdzm_rec_group_report')
### 覆盖率数据
recCoverRate <- rodps.load.table('tmcs_jx_rec_item_coverRate')
### 推荐分析
#recAnalysis <- rodps.('tmcs_jx_djdzm_add2cart_rec_price_stat')
sql = paste(c("select * from tmcs_jx_djdzm_add2cart_rec_price_stat where ds = '", 
              format(now() - days(1), "%Y%m%d"), "'"),collapse = "")
recAnalysis <- rodps.query(sql)

