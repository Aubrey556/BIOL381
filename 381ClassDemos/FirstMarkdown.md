---
title: "First R Markdown file"
author: "Aubrey Pelletier"
date: "September 4, 2018"
output:
  html_document: 
    keep_md: yes
    number_sections: yes
  pdf_document: default
---



Hello world!     What happens to funny spacing?             Is it preserved?

First line.   
Second line.  
Third Line.  

italic *this way*

boldface **like this**

subscript~lower~

superscript^raised^

strikethrough ~~for mistaks~~

#First level

##Second level

...

######Six level!


lists are easy

- first item
- second item
- third item, and yes it will keep everything aligned, just as it should be for longer text!
     - subitem
         - sub-subitem
      
      
>All musicians are subconciously mathematicians

The Thelonious Monk

Use single backtick for in-line emphasis `like this`.

Show literal text as `3 + pi`.

Start with r to get it to run r code like this 6.1415927.

### Code fencing

```
#Comments are important!
pred <- seq(1,10) # make a vector of integers from 1 to 10
response <- runif(10)
print(response)

# now plot a graph
plot(x=pred, y=response, type="b")

```


```r
#Comments are important!
pred <- seq(1,10) # make a vector of integers from 1 to 10
response <- runif(10)
print(response)

# now plot a graph
plot(x=pred, y=response, type="b")
```



##Links

http://example.com 

[linked phrase](http://example.com)

A [linked phrase] [id]

[id]: http://example.com/ "Title"

## Images
![alt text] [id]

##Tables

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell


```r
library(knitr)
kable(head(iris))
```



 Sepal.Length   Sepal.Width   Petal.Length   Petal.Width  Species 
-------------  ------------  -------------  ------------  --------
          5.1           3.5            1.4           0.2  setosa  
          4.9           3.0            1.4           0.2  setosa  
          4.7           3.2            1.3           0.2  setosa  
          4.6           3.1            1.5           0.2  setosa  
          5.0           3.6            1.4           0.2  setosa  
          5.4           3.9            1.7           0.4  setosa  

######Head command says to use first 6 lines of information (i.e. first 6 lines of data from iris dataset)
##Creating equations with `LaTex`

An `inline` equation is bracketed by single dollar signs $3 + 5 = 8$ like this.

For more complex equations, we will render them on a single line by using a double dollar sign to bracket them:

$$3 + 5 = 8$$

Keeps this as a stand-alone piece.

Subscripts as follows:

$$H_0 = Z_{a + b_{3z}}$$

##Fractions and Greek symbols

$$\alpha = \frac{\beta}{\delta + \gamma_{x=3}}$$

##Summation Sign

$$z=\sum_{i=1}^{J-1}{K_i}$$

##Escaping backslash character

$$ \backslash \alpha \le b \backslash$$

##Mixing plain text in LaTex

$$P(\mbox{Occurrence Of Species A}) = Z$$
