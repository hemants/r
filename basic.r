# Variable assingment
v1 <- 5
10 -> v2
v3 =  v1 + v2

#Basic data type in R

var_num = 10
class(var_num) #1. numeric

var_str = "insofe"
class(var_str) #2. character

var_bool = TRUE
class(var_bool) #3. logical

var_comples = 2+3i
class(var_comples) #4. complex

#Basic operator
1+2
1-2
1/4
1%/%4 #only whole number
1*2
5%%2 # mod/reminder

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
vector_num = c(1,2,3,4)
vector_num
class(vector_num)

vector_str = c('a','b',"d")
vector_str
class(vector_str)

vector_bool_1 = c(TRUE,TRUE, FALSE)
vector_bool_2 = c(T,F)
class(vector_bool_2)

vector_all = c(1,2,'ab',T)
vector_all
class(vector_all) #character

vector_all_1 = c(1,2,T,F)
class(vector_all_1) #numeric

#Sequeance
1:10
vector_seq = 1:5
vector_seq_1 = c(1:2,100:102,500)

#letters
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
seq(12,15)
seq(1,10,2)  #step by 2

#assign 3
vec_a = c(75:350)
vec_a
vec_a%%2 == 0
result = vec_a[vec_a%%2 == 0]
result

result1 = vec_a[vec_a%%2 == 0 | vec_a%%3 == 0]
vec_a%%2 == 0 | vec_a%%3 == 0
result1

result3 = vec_a[vec_a%%2 == 0 & vec_a%%5 == 0]
result3

#arithematic operations
a = c(1:10)
b = (11:20)
c = a  + b
c

d = c(1)
e =(1:10)
f = d + e
f
f = d - e
f

#materices -- collection of vectors
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
