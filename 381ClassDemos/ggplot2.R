# multi panel layouts in ggplot and other cool stuff
# November 8, 2018
#AMP
library(ggplot2)
library(ggthemes)
d <- mpg
library(patchwork)

g1 <- ggplot(data=d,
             mapping=aes(x=displ,y=cty))+
  geom_point() +
  geom_smooth()
print(g1)

g2 <- ggplot(data=d,
             mapping=aes(x=fl, fill=I("tomato"), 
                         color=I("black"))) +
  geom_bar(stat="count") +
  theme(legend.position="none")
print(g2)

g3 <- ggplot(data=d,
             mapping=aes(x=displ,
                         fill=I("royalblue"),
                         color=I("black"))) +
  geom_histogram()
print(g3)             

g4 <- ggplot(data=d,
             mapping=aes(x=fl,
                         y=cty,
                         fill=fl)) +
               geom_boxplot() +
               theme(legend.position="none")
print(g4)

#place 2 plots horizonally
g1+g2

# place 3 plots vertically
g1 + g2 +g3 + plot_layout(ncol=1)

# change relative plotting areas
g1+ g2+ plot_layout(ncol=1, heights=c(2,1))
g1 + g2 + plot_layout(ncol=2, widths=c(1,2))

# add a spacer plot
g1+ plot_spacer() + g2

# use nested layouts
g1 + {
  g2 + {
    g3 +
      g4 +
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol=1)

# operator - for subtrack placement
g1+g2 - g3 + plot_layout(ncol=1)

# / and | for intuitive layouts
(g1|g2|g3)/g4
(g1 | g2)/(g3 | g4)

# swapping axis orientation
g3a <- g3 + scale_x_reverse()
g3a
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3|g3a)/(g3b|g3c)

# coordinate flip
(g3 + coord_flip() | g3a + coord_flip())/(g3b + coord_flip() |g3c + coord_flip())

# mapping of aesthetics
# mapping of a discrete variable to color
m1 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, color=class)) +
  geom_point(size=3)
print(m1)             

# map class
m2 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, shape=class)) +
  geom_point(size=3)
print(m2)

# map discrete variable to size
m3 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, size=class)) + geom_point()
print(m3)

#map a continuous variable to size 
m4 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, size=hwy)) +   geom_point()
print(m4)    

# map a continuous variable to color 
m5 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, color=hwy)) + geom_point(size=3)
print(m5)    

# map multiple variables
m6 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, color=hwy, shape=class)) + geom_point(size=4)
print(m6)    

# use shape for fewer categories

m7 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, color=fl, shape=drv)) +
  geom_point(size=4)
print(m7)    

# add 3 aesthetics, size, shape, and color
m8 <- ggplot(data=mpg,
             mapping=aes(x=displ, y= cty, color=fl, shape=drv, size=hwy)) + geom_point()
print(m8)    

# faceting features of ggplot to add additional attributes

# basic faceting rows, cols,
m1 <- ggplot(data=mpg, 
             mapping=aes(x=displ, y=cty)) + geom_point() + facet_grid(class~fl)
m1

# free scales
m1 + facet_grid(class~fl, scales="free_y")
m1 + facet_grid(class~fl, scales="free")

# plot just with rows or columns
m1+ facet_grid(.~class)
m1 + facet_grid(class~.)

# facet wrap versus facet grid - gets rid of empty graphs that facet grid showed

m1 + facet_grid(.~class)
m1 + facet_wrap(~class)
m1 + facet_wrap(~class + fl)

m1 + facet_wrap(~class + fl, drop=FALSE) # keeps the empty grids

# use facets with other aesthetic mappings
m1 <- ggplot(data=mpg,
             mapping=aes(x=displ, y=cty, color=drv)) + geom_point()
m1 + facet_grid(.~class)


# switch to other geoms 
m1 <- ggplot(data=mpg,
             mapping=aes(x=displ, y=cty, color=drv)) + geom_smooth(se=FALSE, method="lm")
m1+ facet_grid(.~class)

# fit with a boxplot over a continous variable
m1 <- ggplot(data=mpg,
             mapping=aes(x=displ, y=cty, color=drv)) + geom_boxplot()
m1 + facet_grid(.~class)

# add a group and a fill mapping 
m1 <- ggplot(data=mpg,
             mapping=aes(x=displ, y=cty, fill=drv, group=drv)) + geom_boxplot()
m1 + facet_grid(.~class)

# addtional control over aesthetics
d <- mpg
p1 <- ggplot(d, mapping=aes(x=displ, y=hwy)) + geom_point() + geom_smooth()
p1

# break out drive types
p2 <- ggplot(d, mapping=aes(x=displ, y=hwy, group=drv)) + geom_point() + geom_smooth()
p2

# break out with color
p1 <- ggplot(d, mapping=aes(x=displ, y=hwy, color=drv)) + geom_point() + geom_smooth()
p1


# change the fill
p1 <- ggplot(d, mapping=aes(x=displ, y=hwy, fill=drv)) + geom_point() + geom_smooth()
p1

# get both effects
p1 <- ggplot(d, mapping=aes(x=displ, y=hwy, color=drv, fill=drv)) + geom_point() + geom_smooth()
p1


# use aesthetics mappings within geoms to override initial settings

p1 <- ggplot(d, mapping=aes(x=displ, y=hwy, col=drv)) + geom_point(data=d[d$drv=="4",]) + geom_smooth()
p1














p1 <- ggplot(d, aes(x=displ, y=hwy))+
  geom_point(mapping=aes(color=drv)) + geom_smooth()
p1

#map for smoother, not points
p1 <- ggplot(d, aes(x=displ, y=hwy))+
  geom_point() + geom_smooth(mapping=aes(color=drv))
p1

# bar plots
table(d$drv)

p1 <- ggplot(d, aes(x=drv)) + geom_bar(color="black", fill="goldenrod")
p1


p1 <- ggplot(d, aes(x=drv, fill=fl)) + geom_bar()
print(p1)

# stack bar and adjust color transparency

p1 <- ggplot(d, aes(x=drv, fill=fl)) +
  geom_bar(alpha= 1/4, position="identity")
p1

# use stacking with proportions adjusted
p1 <- ggplot(d, aes(x=drv, fill=fl)) + geom_bar(position="fill")
print(p1)


# best for mapping is to use dodge for multiple bars

p1 <- ggplot(d, aes(x=drv, fill=fl)) +
  geom_bar(position="dodge", color="black", size=1)
p1

# plotting averages as bars

dTiny <- tapply(X=d$hwy, INDEX=as.factor(d$fl), FUN=mean)
dTiny <- data.frame(hwy=dTiny)
dTiny <- cbind(fl=rownames(dTiny), dTiny)

p2 <- ggplot(dTiny, aes(x=fl, y=hwy, fill=fl)) + geom_col()
print(p2)

# put into a boxplot for more info

p1 <- ggplot(d, aes(x=fl, y=hwy, fill=fl)) +
  geom_boxplot()
print(p1)


# overlay with raw data
p1 <- ggplot(d, aes(x=fl, y=hwy, fill=fl)) +
  geom_boxplot(fill="thistle", outlier.shape=NA) + geom_point(position=position_jitter(width=0.2, height=0.7, color="grey60"))
print(p1)
