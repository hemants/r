#_____________________ Confidence intervals ____________________________
#Q1. A random sample of 100 items is drawn, producing a sample mean of 49. 
# The population SD is 4.49. Construct a 90% confidence interval to estimate the population mean.

sample_size = 100;
x_bar = 49;
sd_population = 4.49;

sd_x_bar = sd_population/sqrt(sample_size);sd_x_bar;

z = qnorm(0.05,0,1);z; #since confidence interval is 90% 
margin_of_error = z*sd_x_bar;

lowerInterval = 49 + margin_of_error;  #48.261
higherInterval = 49 - margin_of_error; #49.739

#Q2. 2 State the null and alternative hypotheses to be used in testing the following claims:
#(a) The mean snowfall at Lake George during the month of February is 21.8 centimeters.
# Answer:  H0: 21.8; bothe tail ended problem. critical region are on bothe side.

#(b) No more than 20% of the faculty at the local university contributed to the annual giving fund.
#Also, determine where the critical region is located.
# Answer: H1: <= 20, critical region lies on left side.

#Q3. A random sample of 35 items is taken, producing a sample mean of 2.364 with a sample variance of 0.81. 
# Assume x is normally distributed and construct a 90% confidence interval for the population mean.

sample_size = 35;
x_bar = 2.364;
sample_var = 0.81

sd_x_bar = sqrt(0.81)/sqrt(sample_size);sd_x_bar;
z = qnorm(0.05,0,1);z; #since confidence interval is 90% 

margin_of_error = z*sd_x_bar;

lowerInterval = 2.364 + margin_of_error;  #2.614
higherInterval = 2.364 - margin_of_error; #2.114

# __________________  Hypotheses testing ________________________________
#Q4. A car manufacturer claims a model has an good as mpg of 25. A consumer group asks 40 owners of this
# model to calculate their mpg and the mean value was 22 with a standard deviation of 1.5. Is the
# manufacturer's claim supported?

#step1:
#H0: mue >= 25
#Ha: mue < 25

mu = 25;

#step2:
x_bar = 22;
sample_size = 40;
sd = 1.5;

z = (x_bar - mu)/(sd/sqrt(40))

#considering 95% of confidence.
qnorm(0.05,0,1)



#Q5. Rainfall from 20 clouds at different locations was measured in inches as follows: 
# 18.0,30.7,19.8,27.1,22.3,18.8,31.8,23.4,21.2,27.9,31.9,27.1,25.0, 24.7,26.9,21.8,29.2,34.8,26.7,31.6. 
# Can you support the claim that mean rainfall exceeds 25 inches? Use 𝛼 = 0.01

#step1:
#H0: mue > 25
#Ha: mue <= 25
mu = 25;
# critical is on lower talil.

#step2:
n = 20;
x_bar = mean(c(18,30.7,19.8,27.1,22.3,18.8,31.8,23.4,21.2,27.9,31.9,27.1,25.0, 24.7,26.9,21.8,29.2,34.8,26.7,31.6));
sd_bar = sd(c(18,30.7,19.8,27.1,22.3,18.8,31.8,23.4,21.2,27.9,31.9,27.1,25.0, 24.7,26.9,21.8,29.2,34.8,26.7,31.6));

t = (x_bar - mu)/(sd_bar/sqrt(20));

#step3:
alphs = 0.01;
dof = 19;

#step4:
cv = qt(0.01,19)

t > cv
# since above is true, now accepct H0.

#Q6. A sample of 20 students took a test before and after attending a particular training session on 
# communication skills. Find out if the training session improved the students’ communication skills, 
# based on the test results.
# Scores before the Training: 17,19,17,21,18,25,17,15,14,21,15,16,16,19,19,21,12,22,15,17. 
# Scores after the Training: 22,25,19,24,16,29,20,23,19,20,17,15,18,25,14,24,18,25,19,14.

#step1: 
#H0: there is no impact
#H1: there is an impact

score_dt = c(17,19,17,21,18,25,17,15,14,21,15,16,16,19,19,21,12,22,15,17);
score_at = c(22,25,19,24,16,29,20,23,19,20,17,15,18,25,14,24,18,25,19,14);

mean_dt = mean(score_dt)
sd_dt = sd(score_dt)

mean_at = mean(score_at)
sd_at = sd(score_at)

score_diff = score_at - score_dt;

# use t distrubution and t-test as number of sample is 20
# also is paired, since sample is same for both experiment.
mean_diff = mean(score_diff)
sd_diff = sd(score_diff)

t_Stat = mean_diff / (sd_diff/sqrt(20)) #3.30827756

qt(0.05,20)
pt(t_Stat, 20)

#Q7. Two types of music, type-I and type-II, have different effects on student’s ability to perform a 
# series of 40 tasks that requires concentration. Number of topics completed by each student under both 
# environments is listed below. The two types of music are independent of each other, and assume that the 
# sampling distribution follows a normal distribution.

#Q8. A survey is conducted by a gaming company that makes three video games. 
# It wants to know if the preference of game depends on the gender of the player. 
# Total number of participants is 1000. Here is the survey result.
# a. State the null hypothesis and alternate hypothesis b. Calculate the degrees of freedom
# c. Does men's preference differ from women's preference? Check with 0.05 level of significance
