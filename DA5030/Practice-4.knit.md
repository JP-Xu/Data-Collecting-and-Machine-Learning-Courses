
<!-- rnb-text-begin -->

---
title: "Assignment 4"
author: "Jiaming Xu"
output: html_notebook
---

## Q1:



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0bSlcbmBgYCJ9 -->

```r
library(tm)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiTG9hZGluZyByZXF1aXJlZCBwYWNrYWdlOiBOTFBcblxuQXR0YWNoaW5nIHBhY2thZ2U6IOKAmE5MUOKAmVxuXG5UaGUgZm9sbG93aW5nIG9iamVjdCBpcyBtYXNrZWQgZnJvbSDigJhwYWNrYWdlOmdncGxvdDLigJk6XG5cbiAgICBhbm5vdGF0ZVxuIn0= -->

```
Loading required package: NLP

Attaching package: ‘NLP’

The following object is masked from ‘package:ggplot2’:

    annotate
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX3JhdyA8LSByZWFkLmNzdihcImh0dHBzOi8vZGE1MDMwLndlZWJseS5jb20vdXBsb2Fkcy84LzYvNS85Lzg2NTk1NzYvZGE1MDMwLnNwYW1tc2dkYXRhc2V0LmNzdlwiLCBzdHJpbmdzQXNGYWN0b3JzID0gRkFMU0UpXG5zbXNfcmF3JHR5cGUgPC0gZmFjdG9yKHNtc19yYXckdHlwZSlcbnRhYmxlKHNtc19yYXckdHlwZSlcbmBgYCJ9 -->

```r
sms_raw <- read.csv("https://da5030.weebly.com/uploads/8/6/5/9/8659576/da5030.spammsgdataset.csv", stringsAsFactors = FALSE)
sms_raw$type <- factor(sms_raw$type)
table(sms_raw$type)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG4gaGFtIHNwYW0gXG40ODI3ICA3NDcgXG4ifQ== -->

```

 ham spam 
4827  747 
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX2NvcnB1cyA8LSBWQ29ycHVzKFZlY3RvclNvdXJjZShzbXNfcmF3JHRleHQpKVxuaW5zcGVjdChzbXNfY29ycHVzWzE6Ml0pXG5gYGAifQ== -->

```r
sms_corpus <- VCorpus(VectorSource(sms_raw$text))
inspect(sms_corpus[1:2])
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiPDxWQ29ycHVzPj5cbk1ldGFkYXRhOiAgY29ycHVzIHNwZWNpZmljOiAwLCBkb2N1bWVudCBsZXZlbCAoaW5kZXhlZCk6IDBcbkNvbnRlbnQ6ICBkb2N1bWVudHM6IDJcblxuW1sxXV1cbjw8UGxhaW5UZXh0RG9jdW1lbnQ+PlxuTWV0YWRhdGE6ICA3XG5Db250ZW50OiAgY2hhcnM6IDExMVxuXG5bWzJdXVxuPDxQbGFpblRleHREb2N1bWVudD4+XG5NZXRhZGF0YTogIDdcbkNvbnRlbnQ6ICBjaGFyczogMjlcbiJ9 -->

```
<<VCorpus>>
Metadata:  corpus specific: 0, document level (indexed): 0
Content:  documents: 2

[[1]]
<<PlainTextDocument>>
Metadata:  7
Content:  chars: 111

[[2]]
<<PlainTextDocument>>
Metadata:  7
Content:  chars: 29
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX2NvcnB1c19jbGVhbiA8LSB0bV9tYXAoIHNtc19jb3JwdXMsIGNvbnRlbnRfdHJhbnNmb3JtZXIoIHRvbG93ZXIpKVxuc21zX2NvcnB1c19jbGVhbiA8LSB0bV9tYXAoc21zX2NvcnB1c19jbGVhbiwgcmVtb3ZlTnVtYmVycylcbnNtc19jb3JwdXNfY2xlYW4gPC0gdG1fbWFwKHNtc19jb3JwdXNfY2xlYW4scmVtb3ZlV29yZHMsIHN0b3B3b3JkcygpKVxuc21zX2NvcnB1c19jbGVhbiA8LSB0bV9tYXAoc21zX2NvcnB1c19jbGVhbiwgcmVtb3ZlUHVuY3R1YXRpb24pXG5zbXNfY29ycHVzX2NsZWFuIDwtIHRtX21hcChzbXNfY29ycHVzX2NsZWFuLCBzdGVtRG9jdW1lbnQpXG5zbXNfY29ycHVzX2NsZWFuIDwtIHRtX21hcChzbXNfY29ycHVzX2NsZWFuLCBzdHJpcFdoaXRlc3BhY2UpXG5zbXNfZHRtIDwtIERvY3VtZW50VGVybU1hdHJpeChzbXNfY29ycHVzX2NsZWFuKVxuc21zX2R0bVxuYGBgIn0= -->

```r
sms_corpus_clean <- tm_map( sms_corpus, content_transformer( tolower))
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)
sms_corpus_clean <- tm_map(sms_corpus_clean,removeWords, stopwords())
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)
sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiPDxEb2N1bWVudFRlcm1NYXRyaXggKGRvY3VtZW50czogNTU3NCwgdGVybXM6IDY1OTIpPj5cbk5vbi0vc3BhcnNlIGVudHJpZXM6IDQyNjA4LzM2NzAxMjAwXG5TcGFyc2l0eSAgICAgICAgICAgOiAxMDAlXG5NYXhpbWFsIHRlcm0gbGVuZ3RoOiA0MFxuV2VpZ2h0aW5nICAgICAgICAgIDogdGVybSBmcmVxdWVuY3kgKHRmKVxuIn0= -->

```
<<DocumentTermMatrix (documents: 5574, terms: 6592)>>
Non-/sparse entries: 42608/36701200
Sparsity           : 100%
Maximal term length: 40
Weighting          : term frequency (tf)
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX2R0bTIgPC0gRG9jdW1lbnRUZXJtTWF0cml4KHNtc19jb3JwdXMsIGNvbnRyb2wgPSBsaXN0KFxuICAgIHRvbG93ZXIgPSBUUlVFLFxuICAgIHJlbW92ZU51bWJlcnMgPSBUUlVFLFxuICAgIHN0b3B3b3JkcyA9IFRSVUUsXG4gICAgcmVtb3ZlUHVuY3R1YXRpb24gPSBUUlVFLFxuICAgIHN0ZW1taW5nID0gVFJVRVxuKSlcbmBgYCJ9 -->

```r
sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
    tolower = TRUE,
    removeNumbers = TRUE,
    stopwords = TRUE,
    removePunctuation = TRUE,
    stemming = TRUE
))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX2R0bV90cmFpbiA8LSBzbXNfZHRtWzE6NDE2OSwgXVxuc21zX2R0bV90ZXN0ICA8LSBzbXNfZHRtWzQxNzA6NTU1OSwgXVxuc21zX3RyYWluX2xhYmVscyA8LSBzbXNfcmF3WzE6NDE2OSwgXSR0eXBlXG5zbXNfdGVzdF9sYWJlbHMgIDwtIHNtc19yYXdbNDE3MDo1NTU5LCBdJHR5cGVcblxuI3dvcmRjbG91ZChzbXNfY29ycHVzX2NsZWFuLCBtaW4uZnJlcSA9IDUwLCByYW5kb20ub3JkZXIgPSBGQUxTRSlcbiNzcGFtIDwtIHN1YnNldChzbXNfcmF3LCB0eXBlID09IFwic3BhbVwiKVxuI2hhbSA8LSBzdWJzZXQoc21zX3JhdywgdHlwZSA9PSBcImhhbVwiKVxuI3dvcmRjbG91ZChzcGFtJHRleHQsIG1heC53b3JkcyA9IDQwLCBzY2FsZSA9IGMoMywgMC41KSlcbiN3b3JkY2xvdWQoaGFtJHRleHQsIG1heC53b3JkcyA9IDQwLCBzY2FsZSA9IGMoMywgMC41KSlcbmBgYCJ9 -->

```r
sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test  <- sms_dtm[4170:5559, ]
sms_train_labels <- sms_raw[1:4169, ]$type
sms_test_labels  <- sms_raw[4170:5559, ]$type

#wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)
#spam <- subset(sms_raw, type == "spam")
#ham <- subset(sms_raw, type == "ham")
#wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
#wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeSh0bSlcbnNtc19mcmVxX3dvcmRzIDwtIGZpbmRGcmVxVGVybXMoc21zX2R0bV90cmFpbiwgNSlcbnNtc19kdG1fZnJlcV90cmFpbiA8LSBzbXNfZHRtX3RyYWluWyAsIHNtc19mcmVxX3dvcmRzXVxuc21zX2R0bV9mcmVxX3Rlc3QgPC0gc21zX2R0bV90ZXN0WyAsIHNtc19mcmVxX3dvcmRzXVxuY29udmVydF9jb3VudHMgPC0gZnVuY3Rpb24oeCkge1xuICAgIHggPC0gaWZlbHNlKHggPiAwLCBcIlllc1wiLCBcIk5vXCIpXG59XG5cbnNtc190cmFpbiA8LSBhcHBseShzbXNfZHRtX2ZyZXFfdHJhaW4sIE1BUkdJTiA9IDIsY29udmVydF9jb3VudHMpXG5zbXNfdGVzdCAgPC0gYXBwbHkoc21zX2R0bV9mcmVxX3Rlc3QsIE1BUkdJTiA9IDIsY29udmVydF9jb3VudHMpXG5cbmxpYnJhcnkoZTEwNzEpXG5zbXNfY2xhc3NpZmllciA8LSBuYWl2ZUJheWVzKHNtc190cmFpbiwgc21zX3RyYWluX2xhYmVscylcbnNtc190ZXN0X3ByZWQgPC0gcHJlZGljdChzbXNfY2xhc3NpZmllciwgc21zX3Rlc3QpXG5saWJyYXJ5KGdtb2RlbHMpXG5Dcm9zc1RhYmxlKHNtc190ZXN0X3ByZWQsIHNtc190ZXN0X2xhYmVscyxcbiAgICBwcm9wLmNoaXNxID0gRkFMU0UsIHByb3AuYyA9IEZBTFNFLCBwcm9wLnIgPSBGQUxTRSxcbiAgICBkbm4gPSBjKCdwcmVkaWN0ZWQnLCAnYWN0dWFsJykpXG5gYGAifQ== -->

```r
library(tm)
sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
sms_dtm_freq_train <- sms_dtm_train[ , sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , sms_freq_words]
convert_counts <- function(x) {
    x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN = 2,convert_counts)
sms_test  <- apply(sms_dtm_freq_test, MARGIN = 2,convert_counts)

library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_train_labels)
sms_test_pred <- predict(sms_classifier, sms_test)
library(gmodels)
CrossTable(sms_test_pred, sms_test_labels,
    prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
    dnn = c('predicted', 'actual'))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG4gXG4gICBDZWxsIENvbnRlbnRzXG58LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXxcbnwgICAgICAgICAgICAgICAgICAgICAgIE4gfFxufCAgICAgICAgIE4gLyBUYWJsZSBUb3RhbCB8XG58LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXxcblxuIFxuVG90YWwgT2JzZXJ2YXRpb25zIGluIFRhYmxlOiAgMTM5MCBcblxuIFxuICAgICAgICAgICAgIHwgYWN0dWFsIFxuICAgcHJlZGljdGVkIHwgICAgICAgaGFtIHwgICAgICBzcGFtIHwgUm93IFRvdGFsIHwgXG4tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfFxuICAgICAgICAgaGFtIHwgICAgICAxMjAwIHwgICAgICAgIDIwIHwgICAgICAxMjIwIHwgXG4gICAgICAgICAgICAgfCAgICAgMC44NjMgfCAgICAgMC4wMTQgfCAgICAgICAgICAgfCBcbi0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLS18XG4gICAgICAgIHNwYW0gfCAgICAgICAgIDkgfCAgICAgICAxNjEgfCAgICAgICAxNzAgfCBcbiAgICAgICAgICAgICB8ICAgICAwLjAwNiB8ICAgICAwLjExNiB8ICAgICAgICAgICB8IFxuLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXxcbkNvbHVtbiBUb3RhbCB8ICAgICAgMTIwOSB8ICAgICAgIDE4MSB8ICAgICAgMTM5MCB8IFxuLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXxcblxuIFxuIn0= -->

```

 
   Cell Contents
|-------------------------|
|                       N |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  1390 

 
             | actual 
   predicted |       ham |      spam | Row Total | 
-------------|-----------|-----------|-----------|
         ham |      1200 |        20 |      1220 | 
             |     0.863 |     0.014 |           | 
-------------|-----------|-----------|-----------|
        spam |         9 |       161 |       170 | 
             |     0.006 |     0.116 |           | 
-------------|-----------|-----------|-----------|
Column Total |      1209 |       181 |      1390 | 
-------------|-----------|-----------|-----------|

 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


One thing interesting here is the laplace argument was set at 1 in the textbook while I set it to -1 here in order to decrease the FP frequency. I don't know why does this happen, but I guess there's some updates in the function so that laplace actually did different things since I just copy paste the original code from textbook to RStudio.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc21zX3Rlc3RfcHJlZDIgPC0gcHJlZGljdChzbXNfY2xhc3NpZmllcjIsIHNtc190ZXN0KVxuc21zX3Rlc3RfcHJlZDIgPC0gcHJlZGljdChzbXNfY2xhc3NpZmllcjIsIHNtc190ZXN0KVxuQ3Jvc3NUYWJsZShzbXNfdGVzdF9wcmVkMiwgc21zX3Rlc3RfbGFiZWxzLFxuICAgIHByb3AuY2hpc3EgPSBGQUxTRSwgcHJvcC5jID0gRkFMU0UsIHByb3AuciA9IEZBTFNFLFxuICAgIGRubiA9IGMoJ3ByZWRpY3RlZCcsICdhY3R1YWwnKSlcblxuYGBgIn0= -->

```r
sms_test_pred2 <- predict(sms_classifier2, sms_test)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labels,
    prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
    dnn = c('predicted', 'actual'))

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG4gXG4gICBDZWxsIENvbnRlbnRzXG58LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXxcbnwgICAgICAgICAgICAgICAgICAgICAgIE4gfFxufCAgICAgICAgIE4gLyBUYWJsZSBUb3RhbCB8XG58LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXxcblxuIFxuVG90YWwgT2JzZXJ2YXRpb25zIGluIFRhYmxlOiAgMTM5MCBcblxuIFxuICAgICAgICAgICAgIHwgYWN0dWFsIFxuICAgcHJlZGljdGVkIHwgICAgICAgaGFtIHwgICAgICBzcGFtIHwgUm93IFRvdGFsIHwgXG4tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tfFxuICAgICAgICAgaGFtIHwgICAgICAxMjA3IHwgICAgICAgIDMxIHwgICAgICAxMjM4IHwgXG4gICAgICAgICAgICAgfCAgICAgMC44NjggfCAgICAgMC4wMjIgfCAgICAgICAgICAgfCBcbi0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLS18LS0tLS0tLS0tLS18XG4gICAgICAgIHNwYW0gfCAgICAgICAgIDIgfCAgICAgICAxNTAgfCAgICAgICAxNTIgfCBcbiAgICAgICAgICAgICB8ICAgICAwLjAwMSB8ICAgICAwLjEwOCB8ICAgICAgICAgICB8IFxuLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXxcbkNvbHVtbiBUb3RhbCB8ICAgICAgMTIwOSB8ICAgICAgIDE4MSB8ICAgICAgMTM5MCB8IFxuLS0tLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXwtLS0tLS0tLS0tLXxcblxuIFxuIn0= -->

```

 
   Cell Contents
|-------------------------|
|                       N |
|         N / Table Total |
|-------------------------|

 
Total Observations in Table:  1390 

 
             | actual 
   predicted |       ham |      spam | Row Total | 
-------------|-----------|-----------|-----------|
         ham |      1207 |        31 |      1238 | 
             |     0.868 |     0.022 |           | 
-------------|-----------|-----------|-----------|
        spam |         2 |       150 |       152 | 
             |     0.001 |     0.108 |           | 
-------------|-----------|-----------|-----------|
Column Total |      1209 |       181 |      1390 | 
-------------|-----------|-----------|-----------|

 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


# Q2:


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudGFibGUocHJlZGljdGlvbiRjbGFzcywgaXJpc3Rlc3RbLDVdKVxuXG5gYGAifQ== -->

```r
table(prediction$class, iristest[,5])

```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgICAgICAgXG4gICAgICAgICAgICAgc2V0b3NhIHZlcnNpY29sb3IgdmlyZ2luaWNhXG4gIHNldG9zYSAgICAgICAgIDEwICAgICAgICAgIDAgICAgICAgICAwXG4gIHZlcnNpY29sb3IgICAgICAwICAgICAgICAgMTAgICAgICAgICAyXG4gIHZpcmdpbmljYSAgICAgICAwICAgICAgICAgIDAgICAgICAgICA4XG4ifQ== -->

```
            
             setosa versicolor virginica
  setosa         10          0         0
  versicolor      0         10         2
  virginica       0          0         8
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->






<!-- rnb-text-end -->

