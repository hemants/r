# Variable assingment
v1 <- 5
10 -> v2
v3 =  v1 + v2

#Basic data type in R
var_num = 10
class(var_num) #1. numeric

var_str = "HemantS"
class(var_str) #2. character

var_bool = TRUE
class(var_bool) #3. logical

var_comples = 2+3i
class(var_comples) #4. complex

#Basic operator
1+2
1-2
1/4
10%/%3 #only whole number
1*2
5%%2 #mod/reminder
5^2

#Logical operator
v1 == v2
v1 <= v2
v3 >= v1
v1 < v3
v2 < v3
v1 != v2
v1 < v2 || v3 < v1
v2 < v2 && v3 < v1

#Built-in data structure
#1.Vector
vector_num = c(1,2,3,4);vector_num
class(vector_num)

vector_str = c('a','b',"d");vector_str;vector_str[1:2]
class(vector_str)

vector_bool = c(TRUE,TRUE, FALSE);vector_bool;class(vector_bool)
vector_bool= c(T,F);vector_bool;class(vector_bool)

vector_all = c(1,2,'ab',T);vector_all
class(vector_all) #character example

vector_all = c(1,2,T,F)
class(vector_all) #numeric example

#create vector using sequeance
1:10
vector_seq = 1:5
vector_seq_1 = c(1:2,100:102,500)

#special keywords for letters
letters
LETTERS

vector_all_char = c(LETTERS)
vector_all_char[1]  #A

#Empty vector
vector_empty = vector() 
class(vector_empty)  #default logical empty vector

#when declaring a empty numeric vector
vec_empty_num = vector(mode = 'numeric')
class(vec_empty_num)

length(vector_empty)  #0
length(vec_empty_num)

#Extract elements from a vector
vector_num = c(1,2,5:10)
vector_num[1]

#Get Sequeance of element by index
vector_num[c(1:2)]

#Get element greater than 5
vector_num>5  #vectorized operation
vector_num[vector_num>5]

#seq function
seq(12,15) #generate number from 12 to 15
seq(1,10,2) #generate number from 1 to 10 but step by 2

#vactor calculation
vec_a = c(75:350);vec_a
vec_a%%2 == 0 #this will perform this check on each element

#this shall get all the values from the VECTOR vec_a which matched to the condition
result = vec_a[vec_a%%2 == 0];result
result = vec_a[vec_a%%2 == 0 | vec_a%%3 == 0];result
result = vec_a[vec_a%%2 == 0 & vec_a%%5 == 0];result

#Vector arithematic operations
a = c(1:10);a
b = (11:20);b
a  + b #sums element at same index

d = c(1,2);d
e =(1:10);e
f = d + e;f
f = d - e;f

#2. Materices -- collection of vectors
matrix(1:9,3,3)
matrix(1:9,3)

#create by row
matrix(1:9,3,3,T)
matrix(1:9,3,byrow=T)

matrix(1:4,4,4,T)

#create 2 matrix 2x3
mat_a = matrix(1:6,2,3)
mat_a
mat_b = matrix(6:11,2,3)
mat_b

mat_a + mat_b
mat_a - mat_b
mat_a * mat_b
mat_a / mat_b


mat_c = matrix(1:6,3,2)
mat_c
mat_a %*% mat_c

#transpose of matrix
t(mat_b)
mat_a %*% t(mat_b)

# use of apply function on matrix
dataMatrix = matrix(1:25,5,5);dataMatrix
# do sum and mean operation by column
apply(dataMatrix, 2, sum)
apply(dataMatrix, 2, mean)

# do sum and mean operation by row
apply(dataMatrix, 1, sum)  
apply(dataMatrix, 1, mean)

#using a for loop on matrix
for(row in 1:nrow(dataMatrix)){
  for(col in 1:ncol(dataMatrix)){
      print(dataMatrix[row,col]); 
  }
}

#now sum all the values in each column
dataMatrix;
for(col in 1:ncol(dataMatrix)){
  print(sum(dataMatrix[,col])); 
}

#now sum all the values in each row
dataMatrix;
for(row in 1:nrow(dataMatrix)){
  print(sum(dataMatrix[row,])); 
}
