library(infotheo)
v = c(1,2,5,6,7,8,9,10);v;
v1 = discretize(v, disc="equalwidth", nbins=2);v1
v2 = discretize(v, disc="equalfreq", nbins=2);v2
