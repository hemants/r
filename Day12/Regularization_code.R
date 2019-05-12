#install.packages("AmesHousing")
library(rsample)  # data splitting 
library(glmnet)   # implementing regularized regression approaches
library(dplyr)    # basic data manipulation procedures
library(ggplot2)  # plotting
library(AmesHousing)


set.seed(123)
ames_split <- initial_split(AmesHousing::make_ames(), prop = .7, strata = "Sale_Price")
ames_train <- training(ames_split)
ames_test  <- testing(ames_split)

lm(Sale_Price ~ Gr_Liv_Area + TotRms_AbvGrd, data = ames_train)

# fit with just Gr_Liv_Area
lm(Sale_Price ~ Gr_Liv_Area, data = ames_train)

# fit with just TotRms_Area
lm(Sale_Price ~ TotRms_AbvGrd, data = ames_train)

# Create training and testing feature model matrices and response vectors.
# we use model.matrix(...)[, -1] to discard the intercept
ames_train_x <- model.matrix(Sale_Price ~ ., ames_train)[, -1]
ames_train_y <- log(ames_train$Sale_Price)

ames_test_x <- model.matrix(Sale_Price ~ ., ames_test)[, -1]
ames_test_y <- log(ames_test$Sale_Price)

# What is the dimension of of your feature matrix?
dim(ames_train_x)

# Apply Ridge regression to ames data. Alpha =0 is Ridge
ames_ridge <- glmnet(
  x = ames_train_x,
  y = ames_train_y,
  alpha = 0
)

plot(ames_ridge, xvar = "lambda")

# Apply CV Ridge regression to ames data
ames_ridge <- cv.glmnet(
  x = ames_train_x,
  y = ames_train_y,
  alpha = 0
)

# plot results
plot(ames_ridge)

min(ames_ridge$cvm)

ames_ridge$lambda.min     # lambda for this min MSE

ames_ridge$cvm[ames_ridge$lambda == ames_ridge$lambda.1se]  # 1 st.error of min MSE

ames_ridge$lambda.1se  # lambda for this MSE


ames_ridge_min <- glmnet(
  x = ames_train_x,
  y = ames_train_y,
  alpha = 0
)

plot(ames_ridge_min, xvar = "lambda")
abline(v = log(ames_ridge$lambda.1se), col = "red", lty = "dashed")

#install.packages("broom")
#install.packages("tidyr")
library(broom)
library(tidyr)
coef(ames_ridge, s = "lambda.1se") %>%
  tidy() %>%
  filter(row != "(Intercept)") %>%
  top_n(25, wt = abs(value)) %>%
  ggplot(aes(value, reorder(row, value))) +
  geom_point() +
  ggtitle("Top 25 influential variables") +
  xlab("Coefficient") +
  ylab(NULL)

# Lasso Regularized Regression =>  Alpha=1
ames_lasso <- glmnet(  x = ames_train_x,  y = ames_train_y,  alpha = 1 )
plot(ames_lasso, xvar = "lambda")

#CV for Lasso
ames_lasso <- cv.glmnet( x = ames_train_x, y = ames_train_y, alpha = 1)
plot(ames_lasso)




min(ames_lasso$cvm)


ames_lasso$lambda.min

ames_lasso$cvm[ames_lasso$lambda == ames_lasso$lambda.1se]

ames_lasso$lambda.1se  # lambda for this MSE



ames_lasso_min <- glmnet(
  x = ames_train_x,
  y = ames_train_y,
  alpha = 1
)

plot(ames_lasso_min, xvar = "lambda")
abline(v = log(ames_lasso$lambda.min), col = "red", lty = "dashed")
abline(v = log(ames_lasso$lambda.1se), col = "red", lty = "dashed")


coef(ames_lasso, s = "lambda.1se") %>%
  tidy() %>%
  filter(row != "(Intercept)") %>%
  ggplot(aes(value, reorder(row, value), color = value > 0)) +
  geom_point(show.legend = FALSE) +
  ggtitle("Influential variables") +
  xlab("Coefficient") +
  ylab(NULL)

min(ames_ridge$cvm)
min(ames_lasso$cvm)


lasso    <- glmnet(ames_train_x, ames_train_y, alpha = 1.0) 
elastic1 <- glmnet(ames_train_x, ames_train_y, alpha = 0.25) 
elastic2 <- glmnet(ames_train_x, ames_train_y, alpha = 0.75) 
ridge    <- glmnet(ames_train_x, ames_train_y, alpha = 0.0)

par(mfrow = c(2, 2), mar = c(5, 3, 5, 2) + 0.1)
plot(lasso, xvar = "lambda", main = "Lasso (Alpha = 1)\n\n\n")
plot(elastic1, xvar = "lambda", main = "Elastic Net (Alpha = .25)\n\n\n")
plot(elastic2, xvar = "lambda", main = "Elastic Net (Alpha = .75)\n\n\n")
plot(ridge, xvar = "lambda", main = "Ridge (Alpha = 0)\n\n\n")


# maintain the same folds across all models
fold_id <- sample(1:10, size = length(ames_train_y), replace=TRUE)

# search across a range of alphas
tuning_grid <- tibble::tibble(
  alpha      = seq(0, 1, by = .1),
  mse_min    = NA,
  mse_1se    = NA,
  lambda_min = NA,
  lambda_1se = NA
)



for(i in seq_along(tuning_grid$alpha)) {
  
  # fit CV model for each alpha value
  fit <- cv.glmnet(ames_train_x, ames_train_y, alpha = tuning_grid$alpha[i], foldid = fold_id)
  
  # extract MSE and lambda values
  tuning_grid$mse_min[i]    <- fit$cvm[fit$lambda == fit$lambda.min]
  tuning_grid$mse_1se[i]    <- fit$cvm[fit$lambda == fit$lambda.1se]
  tuning_grid$lambda_min[i] <- fit$lambda.min
  tuning_grid$lambda_1se[i] <- fit$lambda.1se
}

tuning_grid


tuning_grid %>%
  mutate(se = mse_1se - mse_min) %>%
  ggplot(aes(alpha, mse_min)) +
  geom_line(size = 2) +
  geom_ribbon(aes(ymax = mse_min + se, ymin = mse_min - se), alpha = .25) +
  ggtitle("MSE ± one standard error")


cv_lasso   <- cv.glmnet(ames_train_x, ames_train_y, alpha = 1.0)
min(cv_lasso$cvm)


pred <- predict(cv_lasso, s = cv_lasso$lambda.min, ames_test_x)
mean((ames_test_y - pred)^2)




library(caret)

train_control <- trainControl(method = "cv", number = 10)

caret_mod <- train(
  x = ames_train_x,
  y = ames_train_y,
  method = "glmnet",
  preProc = c("center", "scale", "zv", "nzv"),
  trControl = train_control,
  tuneLength = 10
)

caret_mod

library(h2o)
h2o.init()



# convert data to h2o object
ames_h2o <- ames_train %>%
  mutate(Sale_Price_log = log(Sale_Price)) %>%
  as.h2o()

# set the response column to Sale_Price_log
response <- "Sale_Price_log"

# set the predictor names
predictors <- setdiff(colnames(ames_train), "Sale_Price")


# try using the `alpha` parameter:
# train your model, where you specify alpha
ames_glm <- h2o.glm(
  x = predictors, 
  y = response, 
  training_frame = ames_h2o,
  nfolds = 10,
  keep_cross_validation_predictions = TRUE,
  alpha = .25
)

# print the mse for the validation data
print(h2o.mse(ames_glm, xval = TRUE))

# grid over `alpha`
# select the values for `alpha` to grid over
hyper_params <- list(
  alpha = seq(0, 1, by = .1),
  lambda = seq(0.0001, 10, length.out = 10)
)

# this example uses cartesian grid search because the search space is small
# and we want to see the performance of all models. For a larger search space use
# random grid search instead: {'strategy': "RandomDiscrete"}

# build grid search with previously selected hyperparameters
grid <- h2o.grid(
  x = predictors, 
  y = response, 
  training_frame = ames_h2o, 
  nfolds = 10,
  keep_cross_validation_predictions = TRUE,
  algorithm = "glm",
  grid_id = "ames_grid", 
  hyper_params = hyper_params,
  search_criteria = list(strategy = "Cartesian")
)

# Sort the grid models by mse
sorted_grid <- h2o.getGrid("ames_grid", sort_by = "mse", decreasing = FALSE)
sorted_grid

# grab top model id
best_h2o_model <- sorted_grid@model_ids[[1]]
best_model <- h2o.getModel(best_h2o_model)

