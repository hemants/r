#probabality
all = c(5,10,15,20,25,30,35,40,45,50)
all[all>30]
all[all%%2==0 & all%%5==0]

a = matrix(data=c(1:5,"a"),nrow=2,byrow = T,dimnames = list(c('r1','r2'),c('c1','c2','c3')))

#get first element of matrix
a[1]
#get second element of matrix
a[2]
#get second element from first row
a[1,2]
#get second row, third element 
a[2,3]



#add/attach row
r1 = c(1,2,3)
r2 = c(4,5,6)
r3 = c(1,2,3,4,5)
cbind(r1,r2)
rbind(r1,r2)
cbind(r1,r3)
#add/atach column

#Dataframe
col1 = c(1:2)
col2 = c(T,F)
col3 = c('a','b')
df = data.frame(col1,col2,col3)
#get first column
df[1]
#get first column as vector
df_typ=df[,1];class(df_typ)
#get first row
df[1,]
#get send element from first row
df[1,2]

nrow(df)
ncol(df)
names(df)
colnames(df)
dim(df)
summary(df)
str(df)
