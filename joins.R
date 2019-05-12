#Joins in R - using merge commands

a = data.frame(Name=c("Alpha","Beta","Gama","Delta"), Age=c(24,25,23,28))

b = data.frame(Name=c("Alpha","Gama","Zeta","Psi"), Edu=c("M","D","B","H"))

a;
b;
merge(a,b,by.x="Name", by.y = "Name", all.x=T) #left join
merge(a,b,by.x="Name", by.y = "Name", all.x=F) #left join ?????
merge(a,b,by.x="Name", by.y = "Name", all.y=T) #right join
merge(a,b,by.x="Name", by.y = "Name", all.y=F) #right join ?????
merge(a,b,by.x="Name", by.y = "Name", all=T) #union
merge(a,b,by.x="Name", by.y = "Name", all=F) #intersection
