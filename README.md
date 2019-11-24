# 네이버 영화 분석
www.movie.naver.com와 R를 이용하여 분석을 해본다.
****
<h2> 사용 라이브러리 </h2>

* library("rvest")
* library("R6")
* library("XML")
* library("wordcloud")
* library("RColorBrewer")
* library("tidyverse")   
* library("KoNLP")  

<h2> 프로그램 소개 </h2>

* https://movie.naver.com/movie/point/af/list.nhn 파싱
* 10000개의 데이터를 분석하였다
* 댓글, 평점, 영화 빈도수 크롤링
* 그래프를 그려 영화별 상관관계를 분석
* 워드클라우드를 활용하여 영화의 선호도 및 분위기 분석

<h2> 분석 결과 </h2>

* 평점과 빈도 수 사이에서는 유의미한 결과를 발견하지 못했다.
* 영화의 종합 워드클라우드로 현재 영화 시장의 분위기를 파악하기 수월하였다.
* 각 영화별 워드클라우드에서 영화에 분위기에따라 전혀다른 단어들의 분포를 만드는 것을 확인하였다.

 ****
 
<h2> 1. 영화 종합분석 (10000개 데이터) </h2>

<h3> 1.1. 겨울 왕국을 제외한 최근 영화 빈도수와 평점 </h3>

* 겨울왕국은 빈도수가 앞도적으로 높아 같이 분석을 할 수 없었다.

![Alt text](/img/movie_gragh.JPG)

<h3> 1.2. 영화 단어 클라우드 </h3>

![Alt text](/img/Movie_freg.JPG)

<h3> 1.3. 전체 영화 댓글 단어클라우드(단어수 > 3개상)  </h3>

![Alt text](/img/Movie_issue.JPG)

 ****

<h2> 2. 영화 개별 분석 (각 댓글 1000개) </h2>

<h3> 2.1. 겨울왕국 단어클라우드(단어수 > 3개)  </h3>

![Alt text](/img/frozen_issue.JPG)

<h3> 2.2. 조커 단어클라우드(단어수 > 3개)  </h3>

![Alt text](/img/Joker_issue.JPG)

<h3> 2.3. 82년생 김지영 단어클라우드(단어수 > 3개)  </h3>

![Alt text](/img/82_issue..JPG)

<h3> 2.4. 기생충 단어클라우드(단어수 > 3개)  </h3>

![Alt text](/img/helminth_issue.JPG)

 ****
