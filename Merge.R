## datasets to understands the major differences between the left join
## right joins
A=data.frame(Name=c("Alpha","Beta","Gamma","Delta"), 
             Age=c(24,25,23,28))
B=data.frame(Name=c("Alpha","Gamma","Zeta","Psi"),
             Edu=c("M","D","B","H"))
MergedData1<-merge(A,B,
                   by.x="Name",by.y="Name",
                   all.x=TRUE) #left (outer) join
MergedData1
MergedData2<-merge(A,B,
                   by.x="Name",by.y="Name",
                   all.y=TRUE) #right (outer) join
MergedData2
MergedData3<-merge(A,B,
                   by.x="Name",by.y="Name",
                   all=TRUE) #Full (outer) join
MergedData3

MergedData4<-merge(A,B,
                   by.x="Name",by.y="Name",
                   all=F) #Full (inner) join
MergedData4
