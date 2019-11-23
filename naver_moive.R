
# 패키지 인스톨

 install.packages("rvest")

 install.packages("R6")
 install.packages("XML")
 install.packages('wordcloud') 
 install.packages('wordcloud2') 
 install.packages("tidyverse")  
 install.packages("KoNLP")
# 라이브러리 불러오기

library("rvest")

library("R6")

library("XML")
 
library("wordcloud")

 
library("RColorBrewer")
 
library("tidyverse")   
 
library("KoNLP")  
 
 
# NAVER 영화('메리와 마녀의 꽃') 리뷰 20쪽까지 크롤링



#주소를 복사하여 url_base에 저장
useSejongDic()

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
  #if(length(reviews)==0){break}
  
  all.reviews <- c(all.reviews, reviews)
  all.stars <- c(all.stars, stars)
  all.names <- c(all.names, names)
  # print(page)
  #print(result)
  #print(star)
}
#all.reviews
#데이터 만들기
all.stars
all.names 
all.reviews
####문자 분리하기 

reviews.word <- sapply(all.reviews, extractNoun, USE.NAMES = F)

reviews.word
word_vector= unlist(reviews.word)
word_vector
###############
#########################
name = table(all.names)
film = tapply(as.numeric(all.stars) ,all.names , mean)
film
name
df_film = data.frame(name,film)
###########################
#그래프 그리기 

favor =df_film$film
freq = df_film$Freq
Region = df_film$all.names
#1)
ggplot(df_film, aes(y = m, x = freq,color = Region),xlim =50) + geom_point()


#############################

#워드 클라우드 
all.names 
name = table(all.names)
name=sort(name, decreasing=T)

windows()
palete = brewer.pal(9,"Set1")
wordcloud(names(name), freq=name, scale=c(5,.5), rot.per= .25, min.freq=1, random.order=F, random.color = T, colors=palete,width=1600, height=800)

###########################


#워드 클라우드 2
word_vector <- Filter(function(x){nchar(x)>=3}, word_vector)
name = table(word_vector)
name
#name=head(sort(name, decreasing=T),100)

windows()
palete = brewer.pal(9,"Set1")
wordcloud(names(name), freq=name, scale=c(5,.5), rot.per= .25, min.freq=1, random.order=F, random.color = T, colors=palete,width=1600, height=800)

###########################


