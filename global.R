library(plotly)
library(dplyr)

vote7 <- read.csv("公投第７案.csv", sep = ',', encoding = 'utf-8')
vote8 <- read.csv("公投第８案.csv", sep = ',', encoding = 'utf-8')
vote9 <- read.csv("公投第９案.csv", sep = ',', encoding = 'utf-8')
vote10 <- read.csv("公投第１０案.csv", sep = ',', encoding = 'utf-8')
vote11 <- read.csv("公投第１１案.csv", sep = ',', encoding = 'utf-8')
vote12 <- read.csv("公投第１２案.csv", sep = ',', encoding = 'utf-8')
vote13 <- read.csv("公投第１３案.csv", sep = ',', encoding = 'utf-8')
vote14 <- read.csv("公投第１４案.csv", sep = ',', encoding = 'utf-8')
vote15 <- read.csv("公投第１５案.csv", sep = ',', encoding = 'utf-8')
vote16 <- read.csv("公投第１６案.csv", sep = ',', encoding = 'utf-8')
votingResult <- read.csv("referendum_result.csv", sep = ',', encoding = 'utf-8')


v7 <- vote7[1:22,]
v8 <- vote8[1:22,]
v9 <- vote9[1:22,]
v10 <- vote10[1:22,]
v11 <- vote11[1:22,]
v12 <- vote12[1:22,]
v13 <- vote13[1:22,]
v14 <- vote14[1:22,]
v15 <- vote15[1:22,]
v16 <- vote16[1:22,]

vote7 <- vote7[-c(1:22),]
vote8 <- vote8[-c(1:22),]
vote9 <- vote9[-c(1:22),]
vote10 <- vote10[-c(1:22),]
vote11 <- vote11[-c(1:22),]
vote12 <- vote12[-c(1:22),]
vote13 <- vote13[-c(1:22),]
vote14 <- vote14[-c(1:22),]
vote15 <- vote15[-c(1:22),]
vote16 <- vote16[-c(1:22),]

mergeAllvote <- rbind(v7, v8, v9, v10, v11, v12, v13, v14, v15, v16)
mergeAllvote <- mergeAllvote[-c(3:5)]
mergeAllvote <- mergeAllvote %>%
  group_by(公投案編號) %>%
  mutate(各縣同意率 = 同意票數/sum(同意票數)) %>%
  mutate(各縣投票率 = 投票人數/sum(投票人數))

# mergeAllvote$各縣對各案同意率 <- mergeAllvote$同意票數/mergeAllvote$有效票數
# mergeAllvote$各縣對各案無效票比例 <- mergeAllvote$無效票數/mergeAllvote$投票人數 # 看各案對該縣的影響？


# plotly 1
# vote7$`同意票數佔比` <- vote7[,7]/sum(vote7$同意票數)
# 
# plot1 <- plot_ly(data = vote7, labels = vote7$縣市, values = vote7$同意票數佔, type = 'pie') %>%
#   layout(title = '公投第7案各縣市同意票佔比',
#          xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

# plotly 2
votingResult[,1] = ordered(votingResult[,1], levels = votingResult[,1])
plot2 = plot_ly(data = votingResult,
                x = votingResult$公投案編號,
                y = votingResult$投票率,
                type = "bar",
                marker = list(color = 'rgb(158,202,225)',
                              line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
  layout(title = "2018全國性公民投各案投票率",
         xaxis = list(title = "投票率"),
         yaxis = list(title = "公投案編號"))

# plotly 3
plot3 = plot_ly(data = votingResult,
                x = votingResult$公投案編號,
                y = votingResult$有效同意票數對投票權人數.,
                type = "bar",
                marker = list(color = 'rgb(158,202,225)',
                              line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
  layout(title = "有效同意票數對投票權人數",
         xaxis = list(title = "2018全國性公民投各案有效同意票數對投票權人數"),
         yaxis = list(title = "公投案編號"))
