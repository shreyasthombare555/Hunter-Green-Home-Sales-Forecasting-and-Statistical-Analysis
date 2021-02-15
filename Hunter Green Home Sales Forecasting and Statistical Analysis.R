rm(list=ls())
library(readxl)
master.dataset = read_excel("SDM_Assign2_dataset.xlsx")
colnames(master.dataset) = tolower(make.names(colnames(master.dataset)))
attach(master.dataset)
summary(master.dataset)
nrow(master.dataset)
ncol(master.dataset)


master.dataset$pool = as.numeric(as.factor(master.dataset$pool))
master.dataset$splsale = as.numeric(as.factor(master.dataset$splsale))
master.dataset$roof = as.numeric(as.factor(master.dataset$roof))
master.dataset$yrblt = as.numeric(as.factor(master.dataset$yrblt))
master.dataset$garages = as.numeric(as.factor(master.dataset$garages))
master.dataset$subdivn = as.numeric(as.factor(master.dataset$subdivn))
str(master.dataset)
levels(master.dataset$pool)

clean.dataset = subset(master.dataset, select = -c(slnoskm, address, status, spa, pendingdate, datesold))

#correlation matrix for continuous variable
temp.cor.data = clean.dataset
library(corrplot)
xx = cor(temp.cor.data)
corrplot(xx,method="circle")

unique(yrbit)
unique(clean.dataset$yrblt)
is.factor(clean.dataset$roof)
typeof(clean.dataset)

names(clean.dataset)


adom.sample.1 = lm(adom_agentdaysonmarket~cdom_cumuldaysmls+beds+bathshalf+bathsfull+sqft+garages+roof+
                     lotsqft+yrblt+pool+listprice+lppersqft+sppersqft+splsale+
                     +I(listprice^2)+I(pricesold^2)+I(lppersqft^2)+I(sppersqft^2),data=clean.dataset) 
summary(adom.sample.1)

adom.sample.2 = lm(adom_agentdaysonmarket~sqft+cdom_cumuldaysmls+
                     lotsqft+yrblt+listprice+pricesold+lppersqft+sppersqft+splsale+
                     +listprice:pricesold+I(listprice^2)+I(pricesold^2)+I(lppersqft^2)+I(sppersqft^2)+I(datedifference^2),data=clean.dataset) 
summary(adom.sample.2)

adom.sample.3 = lm(adom_agentdaysonmarket~cdom_cumuldaysmls+beds+bathstotal+sqft+garages+roof+
                     lotsqft+yrblt+pool+listprice+pricesold+lppersqft+sppersqft+splsale+I(splsale^2)+I(listprice^2)
                   +I(pricesold^2)+I(lppersqft^2)+I(sppersqft^2),data=clean.dataset) 
summary(adom.sample.3)

library(stargazer)
stargazer(adom.sample.1,adom.sample.2,adom.sample.3,type="text",title="Regression Results",single.row=TRUE)


#--------------------------------------------------------------------------------

#Linearity 
plot(clean.dataset$adom_agentdaysonmarket,adom.sample.1$fitted.values,pch=19,xlim=c(0,100),ylim=c(0,100),main=" Actuals v. Fitted")
abline(0,1,col="red",lwd=3)    #linear reln

#qqnorm(ols2$res)                              # Q-Q plot
#qqline(ols2$res, col="red")
   
#Normality
qqnorm(adom.sample.1$residuals,pch=19,
       main="Normality Plot")
qqline(adom.sample.1$residuals,lwd=3,col="red")

shapiro.test(adom.sample.1$res)      
# p value less than 0.05 hence data is not normally distributed    
# Shapiro-Wilk's test of multivariate normality

#Equality of variances
# install.packages("car")

#Equality of Variances
plot(clean.dataset$adom_agentdaysonmarket,adom.sample.1$residuals,pch=19,ylim=c(-40,20),xlim=c(0,100),main="Residual Plot")
abline(0,0,col="red",lwd=3)

library("car")
bartlett.test(list(adom.sample.1$res, adom.sample.1$fit))       # Bartlett's test of homoskedasticity
#reject null hypothesis unequal variances.  


leveneTest(adom.sample.1$res, adom.sample.1$fit, center=mean)   # Levene's test of homoskedasticity

# install.packages("lmtest")
library(lmtest)
dwtest(adom.sample.1)                                    # Durbin-Watson test of autocorrelation

#close to 2 no autocorrelation

#Multicollinerity
car::vif(adom.sample.1)


#--------------------------------------------------------------------------------

pricesold.sample.1 = lm(pricesold~beds+bathshalf+bathsfull+sqft+garages+roof+
                          lotsqft+yrblt+pool+listprice+cdom_cumuldaysmls+lppersqft+sppersqft+splsale+
                          I(lppersqft^2)+I(sppersqft^2)+I(cdom_cumuldaysmls^2)+beds:bathstotal
                        +sqft:lotsqft+lppersqft:sppersqft,data=clean.dataset) 

summary(pricesold.sample.1)


pricesold.sample.2 = lm(pricesold~beds+bathstotal+sqft+garages+roof+
                          lotsqft+yrblt+pool+listprice+cdom_cumuldaysmls+lppersqft+sppersqft+splsale+
                          I(lppersqft^2)+I(sppersqft^2)+beds:bathstotal
                        +sqft:lotsqft,data=clean.dataset) 
summary(pricesold.sample.2)

pricesold.sample.3 = lm(pricesold~beds+bathshalf+bathsfull+sqft+garages+roof+
                          lotsqft+yrblt+pool+listprice+adom_agentdaysonmarket+cdom_cumuldaysmls+splsale+
                          I(sqft^2)+
                          I(lotsqft^2)+I(lppersqft^2)+I(sppersqft^2)+
                          cdom_cumuldaysmls:adom_agentdaysonmarket,data=clean.dataset) 

summary(pricesold.sample.3)

confint(pricesold.sample.3)

stargazer(pricesold.sample.1,pricesold.sample.2,pricesold.sample.3,type="text",title="Regression Results",single.row=TRUE)

#--------------------------------------------------------------------------------


#Linearity 
plot(clean.dataset$pricesold,pricesold.sample.3$fitted.values,pch=19, main=" Actuals v. Fitted")
abline(0,1,col="red",lwd=3)  

#qqnorm(ols2$res)                              # Q-Q plot
#qqline(ols2$res, col="red")

#Normality
qqnorm(pricesold.sample.3$residuals,pch=19,
       main="Normality Plot")
qqline(pricesold.sample.3$residuals,lwd=3,col="red")

shapiro.test(pricesold.sample.3$res)      
# p value less than 0.05 hence data is not normally distributed    
# Shapiro-Wilk's test of multivariate normality

#Equality of variances
# install.packages("car")

#Equality of Variances
plot(clean.dataset$pricesold,pricesold.sample.3$residuals,pch=19,xlim=c(100000,800000),ylim=c(-15000,15000),main="Residual Plot")
abline(0,0,col="red",lwd=3)

library("car")
bartlett.test(list(pricesold.sample.3$res, adom.sample.3$fit))       # Bartlett's test of homoskedasticity
#reject null hypothesis unequal variances.  


leveneTest(pricesold.sample.3$res, pricesold.sample.3$fit, center=mean)   # Levene's test of homoskedasticity

# install.packages("lmtest")
library(lmtest)
dwtest(pricesold.sample.3)                                    # Durbin-Watson test of autocorrelation

#close to 2 no autocorrelation

#Multicollinerity
car::vif(pricesold.sample.3)
