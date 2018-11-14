# demos of color palettes in R
# Nov 13, 2018
# AMP

library(ggplot2)
library(ggthemes)
library(patchwork)
library(wesanderson)

# working with basic colors and grey

d <- mpg
p1 <- ggplot(d, aes(x=fl, y=hwy, group=fl))
p1 + geom_boxplot()

p1 + geom_boxplot(fill="red")
myColors <- c("red", "darkgreen", "green", "blue", "orange")
p1 + geom_boxplot(fill=myColors)

# use grey function
p1 + geom_boxplot(fill=gray(seq(from=0.1, to=0.9, length=5)))

# histograms with alpha transparency

x1 <- rnorm(n=100, mean=0)
x2 <- rnorm(n=100, mean=3)
dFrame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control", "Treatment"), each=100)
dFrame <- cbind(dFrame,lab)

h1 <- ggplot(dFrame, aes(x=v1, fill=lab))
h1 + geom_histogram(position="identity", alpha=0.5, color="black") # puts all values on single common scale



p1 +geom_boxplot(fill=wes_palettes[["Royal2"]])
p1 + geom_boxplot(fill=c(grey(0.5), canva_palettes[[1]]))

# use scale fill manual

p2 <- ggplot(d, aes(x=fl, y=hwy, fill=fl)) + 
  geom_boxplot() + 
  scale_fill_manual(values=wes_palettes[["Darjeeling1"]])
p2

p2 + geom_boxplot() +
  scale_fill_brewer(palette="Blues") #this palette can be found at this site:http://colorbrewer2.org/#type=diverging&scheme=PiYG&n=6 

# continuous variables

p3 <- ggplot(d,aes(x=displ, y=hwy, color=cty)) +
  geom_point()
print(p3)

# use a scale_color_gradient to change low and high colors

p3 + scale_color_gradient(low="red", high="blue")

# use scale_ color_gradient2 for a 3 color gradient
z <- mean(d$cty)
p3+ scale_color_gradient2(midpoint=z, low="red", mid="seagreen", high="cyan", space="Lab")


# use scale color gradientn for multicolored changes

p3 + scale_color_gradientn(colors=rainbow(5))

# make heat map show viridis

xVar <- 1:30
yVar <- 1:5
myData <- expand.grid(xVar=xVar, yVar=yVar)
zVar <- myData$xVar + myData$yVar + 2*rnorm(n=150)
myData <- cbind(myData, zVar)

p4 <- ggplot(myData, aes(x=xVar, y=yVar, fill=zVar))
p4+ geom_tile()

p4 + geom_tile() +
  scale_fill_gradient2(midpoint=19, low="brown", mid=grey(0.8), high="darkblue")

# now with new viridis scales
p4 + geom_tile() + scale_fill_viridis_c()

# optional colors viridis, cividis, magma, inferno, plasma


p4 + geom_tile() + scale_fill_viridis_c(option="inferno")

library(colorblindr)
library(colorspace)
library(cowplot)

p4 <- p4 + geom_tile() + scale_fill_viridis_c() 
p4des<-edit_colors(p4, desaturate)
ggdraw(p4des)
