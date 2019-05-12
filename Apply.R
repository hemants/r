M=matrix(seq(1,25,1),5,5)
M
sum(M[,3])
apply(M,2,function(x){ print(x); print(0);})
apply(M,1,sum)

for(i in 1:ncol(M)){
  print(sum(M[,i]))
}

for(i in 1:nrow(M)){
  
  print(sum(M[i,]))
}