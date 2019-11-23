
# 패키지 
 install.packages("rvest")
 install.packages("R6")
 install.packages("XML")
 install.packages('wordcloud') 
 install.packages('wordcloud2') 
 install.packages("tidyverse")  
 install.packages("KoNLP")

# 라이브러리 
library("rvest")
library("R6")
library("XML")
library("wordcloud")
library("RColorBrewer")
library("tidyverse")   
library("KoNLP")  
 
 


useSejongDic() #텍스트 마이닝을 위해 사전 로드 

url_base <- 'https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=136873&target=after&page='


all.reviews <- c()
all.stars <- c()
all.names <- c()

for(page in 1:50){
  
  url <- paste(url_base,page,sep='')
  # read_html 함수를 사용하여 html 페이지를 htxt 변수에 저장
  
  html <- read_html(url,encoding="CP949")
  
  content <- html_nodes(html,'.list_netizen') %>%
    html_nodes('.title')
  
  names <- html_nodes(content,'a.movie.color_b') %>%
    html_text()
  
  stars <- html_nodes(content,'.list_netizen_score') %>%
    html_nodes('em')%>%
    html_text()
  
  result <- html_nodes(content,xpath='//*[@class="title"]/text()') %>%
    html_text()
  
  reviews <- gsub("[\r\n\t]","", result) #r태그, t태그 제거
  reviews = reviews[reviews != ""]
  
  all.reviews <- c(all.reviews, reviews)
  all.stars <- c(all.stars, stars)
  all.names <- c(all.names, names)
}

####문자 분리하기 

reviews.word <- sapply(all.reviews, extractNoun, USE.NAMES = F)
word_vector= unlist(reviews.word)
####문자 분리하기 끝


####평점과 빈도수 데이터 연결
name = table(all.names)
film = tapply(as.numeric(all.stars) ,all.names , mean)
df_film = data.frame(name,film)
df_film2 <- df_film[c(order(-df_film$Freq)),] 
df_film3 = head(df_film2,30)
####연결끝 

####그래프 그리기 
favor =df_film3$film
freq = df_film3$Freq
Region = df_film3$all.names
ggplot(df_film3, aes(y = favor, x = freq,color = Region),xlim=500) + geom_point()+
  xlim(0,800)
####그래프 그리기 끝

#영화 빈도 수 별 워드 클라우드 
all.names 
name = table(all.names)
name=sort(name, decreasing=T)
windows()
palete = brewer.pal(9,"Set1")
wordcloud(names(name), freq=name, scale=c(5,.5), rot.per= .25, min.freq=1, random.order=F, random.color = T, colors=palete,width=1600, height=800)
###########################


#영화 댓글 워드 클라우드 
word_vector <- Filter(function(x){nchar(x)>=3}, word_vector) #단어 최소 길이
name = table(word_vector)
#name=head(sort(name, decreasing=T),100) #최대 갯수 
windows()
palete = brewer.pal(9,"Set1")
wordcloud(names(name), freq=name, scale=c(5,.5), rot.per= .25, min.freq=1, random.order=F, random.color = T, colors=palete,width=1600, height=800)
###########################


