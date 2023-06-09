###################################################
library("lavaan")


###################################################
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9
            '
fit <- cfa(HS.model, data=HolzingerSwineford1939)


HS.model.bis <- ' visual  =~ NA*x1 + x2 + x3
                  textual =~ NA*x4 + x5 + x6
                  speed   =~ NA*x7 + x8 + x9
                  visual  ~~ 1*visual
                  textual ~~ 1*textual
                  speed   ~~ 1*speed
                '
fit <- cfa(HS.model, data=HolzingerSwineford1939, std.lv=TRUE)


HS.model.full <- ' # latent variables
                     visual  =~ 1*x1 + x2 + x3
                     textual =~ 1*x4 + x5 + x6
                     speed   =~ 1*x7 + x8 + x9

                   # residual variances observed variables
                     x1 ~~ x1
                     x2 ~~ x2
                     x3 ~~ x3
                     x4 ~~ x4
                     x5 ~~ x5
                     x6 ~~ x6
                     x7 ~~ x7
                     x8 ~~ x8
                     x9 ~~ x9

                   # factor variances
                     visual  ~~ visual
                     textual ~~ textual
                     speed   ~~ speed

                   # factor covariances
                     visual  ~~ textual + speed
                     textual ~~ speed
                 '
fit <- lavaan(HS.model.full, data=HolzingerSwineford1939)


HS.model.mixed <- ' # latent variables
                       visual  =~ 1*x1 + x2 + x3
                       textual =~ 1*x4 + x5 + x6
                       speed   =~ 1*x7 + x8 + x9

                     # factor covariances
                       visual  ~~ textual + speed
                       textual ~~ speed
                  '
fit <- lavaan(HS.model.mixed, data=HolzingerSwineford1939, 
              auto.var=TRUE)


HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9
            '
fit <- cfa(HS.model, data=HolzingerSwineford1939)
summary(fit, fit.measures=TRUE)


###################################################
parameterEstimates(fit)

Est <- parameterEstimates(fit, ci=FALSE, standardized=TRUE)
subset(Est, op == "=~")

MI <- modificationIndices(fit)
subset(MI, mi > 10)


###################################################
model <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + y2 + y3 + y4
    dem65 =~ y5 + y6 + y7 + y8

  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60

  # residual covariances
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'
fit <- sem(model, data=PoliticalDemocracy)
summary(fit, standardized=TRUE)
coef(fit)


model.equal <- '
  # measurement model
    ind60 =~ x1 + x2 + x3
    dem60 =~ y1 + d1*y2 + d2*y3 + d3*y4
    dem65 =~ y5 + d1*y6 + d2*y7 + d3*y8

  # regressions
    dem60 ~ ind60
    dem65 ~ ind60 + dem60

  # residual covariances
    y1 ~~ y5
    y2 ~~ y4 + y6
    y3 ~~ y7
    y4 ~~ y8
    y6 ~~ y8
'
fit.equal <- sem(model.equal, data=PoliticalDemocracy)
summary(fit.equal)

anova(fit, fit.equal)

fitMeasures(fit, c("cfi", "rmsea"))
inspect(fit)
inspect(fit, what="start")


###################################################
HS.model <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9 '
fit <- cfa(HS.model, data=HolzingerSwineford1939, group="school")


fit.metric <- cfa(HS.model, data=HolzingerSwineford1939, group="school",
                  group.equal=c("loadings","intercepts"))
anova(fit, fit.metric)


fit <- cfa(HS.model, data=HolzingerSwineford1939, se="robust")


fit <- cfa(HS.model, data=HolzingerSwineford1939, missing="listwise", 
           estimator="MLM", mimic="Mplus")
summary(fit, estimates=FALSE, fit.measures=TRUE)


fit <- cfa(HS.model, data=HolzingerSwineford1939, estimator="MLM", 
           mimic="EQS")
fit


###################################################
set.seed(1234)
Data <- data.frame(y = rnorm(100), x1 = rnorm(100), x2 = rnorm(100),
                   x3 = rnorm(100))
model <- ' y ~ b1*x1 + b2*x2 + b3*x3 '
fit <- sem(model, data=Data)
coef(fit)


###################################################
model.constr <- ' # model with labeled parameters
                    y ~ b1*x1 + b2*x2 + b3*x3
                  # constraints
                    b1 == (b2 + b3)^2
                    b1 > exp(b2 + b3) '
fit <- sem(model.constr, data=Data)
summary(fit)


###################################################
set.seed(1234)
X <- rnorm(100)
M <- 0.5*X + rnorm(100)
Y <- 0.7*M + rnorm(100)
Data <- data.frame(X = X, Y = Y, M = M)

model <- ' # direct effect
             Y ~ c*X
           # mediator
             M ~ a*X
             Y ~ b*M
           # indirect effect (a*b)
             ab := a*b
           # total effect
             total := c + (a*b)
         '
fit <- sem(model, data=Data)
summary(fit)
