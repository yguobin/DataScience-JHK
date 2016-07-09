# Week 1
# R has 5 atomic classes: integer, numeric, complex, character, logic
numbers1 = c(1L, Inf, NaN)
numbers2 = c(1, Inf, NaN)
numbers3 = c(1)
x = vector("integer", length = 10)
x = c("a", "b", "c")
as.numeric(x)
m = 1:10
dim(m) = c(2, 5)

x <- factor(c("yes", "yes", "ab", "yes", "ab"))
table(x)
unclass(x)

x <- factor(c("yes", "yes", "no", "yes", "no"), levels = c("yes", "no"))
table(x)

x  = c(1, 2, NaN, NA, 3)
is.na(x)
is.nan(x)

x = 1:3
names(x) = c("one", "two", "three")

x  = 1:4
x > 2
x[x > 2]

x = list(foo = 1:3, bar = c("yes", "yes", "no", "no"))
x[1]
x[[1]]
x[c(1,2)]
x["bar"]
x$bar

x = matrix(1:6, byrow = TRUE, nrow = 2)
x[1, ]
x[1, :]

x[1, 2]
x[1, 2, drop = FALSE]

x[1, ]
x[1, , drop = FALSE]

airquality[1:6, ]
airquality[complete.cases(airquality), ][1:6, ]

x = matrix(1:4, 2, 2)
y = matrix(rep(10, 4), 2, 2)
x * y
x / y
x %*% y

x = 4L
class(x)

x <- c(3, 5, 1, 10, 12, 6)
x[x<6] = 0
x

# Date is Date, Time is POSIXct (integer) or POSIXlt (list)
x = as.Date("1971-01-01")
x = Sys.time()
unclass(x)
x = as.POSIXlt(x)
unclass(x)

x = strptime("2016-07-08 08:00:00", "%Y-%m-%d %H:%M:%S")
y = strptime("2016-07-08 09:00:00", "%Y-%m-%d %H:%M:%S")
y - x

# lapply, sapply, apply, tapply, mapply
x = list(a = 1:5, b = rnorm(10))
lapply(x, mean)
lapply(1:4, runif, min=-10, max=10)
sapply(x, mean)

x = matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
apply(x, 1, mean)
mapply(rnorm, 1:5, 1:5, 2)

x = c(rnorm(10), runif(10), rnorm(10, 1))
f = gl(3, 10)
tapply(x, f, mean)

split(x, f)
s = split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE))


