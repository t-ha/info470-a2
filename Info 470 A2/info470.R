### To ensureyou have the latest version of R installed, see http://www.r-statistics.com/tag/installr/
###
### Independent samples t-test, plus
###    descriptive statistics,
###    histograms,
###    boxplots,
###    Shapiro-Wilk test (normality assumption),
###    Levene's test (homoscedasticity assumption),
###    Brown-Forsythe test (homoscedasticity assumption),
###    Welch t-test (unequal variances)
###
df = read.csv("t-indep.csv") # read in data file, store in "df"
# View(df)
df$Subject = factor(df$Subject) # set Subject as nominal
contrasts(df$Sex) <- "contr.sum"

library(plyr)
summary(df)
# ddply(df, ~ Sex, function(data) summary(data$Hours_Played)) # summary report
# ddply(df, ~ Sex, summarise, Hours.mean=mean(Hours_Played), Hours.sd=sd(Hours_Played))

# hist(df$Hours_Played, xlim=c(0,80), ylim=c(0,4)) # histograms
# hist(df[df$Sex == "Male",]$Hours_Played, xlim=c(0,80), ylim=c(0,4))
# hist(df[df$Sex == "Female",]$Hours_Played, xlim=c(0,80), ylim=c(0,4))

# boxplot(Hours_Played ~ Sex, data=df, xlab="Sex", ylab="Hours_Played") # boxplot
# 
# shapiro.test(df[df$Sex == "Male",]$Hours_Played) # Shapiro-Wilk test for normality
# shapiro.test(df[df$Sex == "Female",]$Hours_Played)
# 
# m = aov(Hours_Played ~ Sex, data=df) # fit an ANOVA model
# shapiro.test(residuals(m)) # test the normality of residuals
# qqnorm(residuals(m)); qqline(residuals(m)) # line should be through points
# anova(m) # ANOVA will agree with t-test below
# 
# library(car)
# install.packages("pbkrtest")
# leveneTest(Hours_Played ~ Sex, data=df, center=mean) # Levene's test
# leveneTest(Hours_Played ~ Sex, data=df, center=median) # Brown-Forsythe test
# 
# t.test(Hours_Played ~ Sex, data=df, var.equal=TRUE) # independent-samples t-test
# t.test(Hours_Played ~ Sex, data=df, var.equal=FALSE) # Welch t-test for unequal variances
# 
# 
# ###
# ### Paired samples t-test, plus
# ###    histograms,
# ###    boxplots
# ###
# df = read.csv("t-paired.csv") # read in data file
# View(df)
# df$Subject = factor(df$Subject) # set Subject as nominal
# contrasts(df$Sex) <- "contr.sum"
# 
# hist(c(df$MMORPG, df$Shooter), xlim=c(0,100), ylim=c(0,6))
# hist(df$MMORPG, xlim=c(0,100), ylim=c(0,4)) # histograms
# hist(df$Shooter, xlim=c(0,100), ylim=c(0,4)) # histograms
# 
# boxplot(df$MMORPG, df$Shooter, names=c("MMORPG", "Shooter"), xlab="Game Type", ylab="Hours_Played")
# 
# t.test(df$MMORPG, df$Shooter, paired=TRUE, var.equal=TRUE) # paired-samples t-test
# 
# 
# ##
# ## One-way ANOVA, plus
###    descriptive statistics,
###    histograms,
###    boxplots,
###    Shapiro-Wilk test,
###    pairwise comparisons,
###    Holm's sequential Bonferroni procedure,
###    ezANOVA,
###    manual pairwise comparisons
###
# df = read.csv("between.csv") # read in data file
# View(df)
# df$Subject = factor(df$Subject)
# contrasts(df$Sex) <- "contr.sum"
# contrasts(df$Game_Type) <- "contr.sum"
# 
# summary(df)
# ddply(df, ~ Game_Type, function(data) summary(data$Hours_Played)) # summary report
# ddply(df, ~ Game_Type, summarise, Hours.mean=mean(Hours_Played), Hours.sd=sd(Hours_Played))
# 
# hist(df$Hours_Played, xlim=c(0,50), ylim=c(0,6)) # histograms
# hist(df[df$Game_Type == "MMORPG",]$Hours_Played, xlim=c(0,50), ylim=c(0,3))
# hist(df[df$Game_Type == "Mystery",]$Hours_Played, xlim=c(0,50), ylim=c(0,3))
# hist(df[df$Game_Type == "Shooter",]$Hours_Played, xlim=c(0,50), ylim=c(0,3))

# boxplot(Hours_Played ~ Game_Type, data=df, xlab="Game_Type", ylab="Hours_Played") # boxplot
# 
# m = aov(Hours_Played ~ Game_Type, data=df) # fit an ANOVA model
# shapiro.test(residuals(m)) # test the normality of residuals with Shapiro-Wilk
# qqnorm(residuals(m)); qqline(residuals(m)) # line should be through points
# anova(m)  # or summary(m)
# 
# library(multcomp)
# library(lsmeans)
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Game_Type))), test=adjusted(type="holm")) # compare all pairs
# summary(glht(m, mcp(Game_Type="Tukey")), test=adjusted(type="holm")) # Note: equivalent, Tukey means compare all pairs
# summary(glht(m, lsm(pairwise ~ Game_Type)), test=adjusted(type="holm")) # Note: equivalent but uses lsm, not mcp
# 
# library(ez) # using ez
# m = ezANOVA(dv=Hours_Played, between=Game_Type, wid=Subject, data=df) 
# m$ANOVA
# 
# v1 = t.test(df[df$Game_Type == "MMORPG",]$Hours_Played, df[df$Game_Type == "Mystery",]$Hours_Played, var.equal=TRUE) # manual pairwise comparisons
# v2 = t.test(df[df$Game_Type == "MMORPG",]$Hours_Played, df[df$Game_Type == "Shooter",]$Hours_Played, var.equal=TRUE)
# v3 = t.test(df[df$Game_Type == "Shooter",]$Hours_Played, df[df$Game_Type == "Mystery",]$Hours_Played, var.equal=TRUE)
# p.adjust(c(v1$p.value, v2$p.value, v3$p.value), method="holm")
# 
# 
# ###
# ### One-way repeated measures ANOVA, plus
# ###    histograms,
# ###    boxplots,
# ###    wide -> long -> wide table format,
# ###    manual pairwise comparisons
# ###
# df = read.csv("mixed.csv")
# View(df)
# df$Subject = factor(df$Subject)
# contrasts(df$Sex) <- "contr.sum"
# 
# hist(c(df$MMORPG, df$Mystery, df$Shooter), xlim=c(0,50), ylim=c(0,12)) # histograms
# hist(df$MMORPG, xlim=c(0,50), ylim=c(0,8)) # histograms
# hist(df$Mystery, xlim=c(0,50), ylim=c(0,8))
# hist(df$Shooter, xlim=c(0,50), ylim=c(0,8))
# 
# boxplot(df$MMORPG, df$Mystery, df$Shooter, names=c("MMORPG", "Mystery", "Shooter"), xlab="Game Type", ylab="Hours_Played")
# 
# library(reshape2) # for reshaping tables
# df2 = melt(df, id.vars=c("Subject","Sex"), measure.vars=c("MMORPG", "Mystery", "Shooter"), variable.name="Game_Type", value.name="Hours_Played") # go long
# View(df2)
# df2 = df2[order(df2$Subject),] # sort by Subject
# View(df2)
# contrasts(df2$Sex) <- "contr.sum"
# contrasts(df2$Game_Type) <- "contr.sum"
# 
# m = aov(Hours_Played ~ Game_Type + Error(Subject/Game_Type), data=df2) # fit ANOVA model
# summary(m)  # show ANOVA
# 
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Game_Type))), test=adjusted(type="holm")) # compare all pairs
# 
# m = ezANOVA(dv=Hours_Played, within=Game_Type, wid=Subject, data=df2) # using ez
# m$ANOVA
# 
# df3 = dcast(df2, Subject + Sex ~ Game_Type, value.var="Hours_Played") # go wide (for drill)
# View(df3) # same as df
# contrasts(df3$Sex) <- "contr.sum"
# 
# v1 = t.test(df3$MMORPG, df3$Mystery, paired=TRUE, var.equal=TRUE) # paired-samples t-tests
# v2 = t.test(df3$MMORPG, df3$Shooter, paired=TRUE, var.equal=TRUE)
# v3 = t.test(df3$Shooter, df3$Mystery, paired=TRUE, var.equal=TRUE)
# p.adjust(c(v1$p.value, v2$p.value, v3$p.value), method="holm")
# 
# 
# ###
# ### Two-way ANOVA, plus
# ###    descriptive statistics,
# ###    boxplots,
# ###    interaction plots,
# ###    Shapiro-Wilk test,
# ###    pairwise comparisons,
# ###    ezANOVA
# ###
# df = read.csv("between.csv") # read in data file
# View(df)
# df$Subject = factor(df$Subject)
# contrasts(df$Sex) <- "contr.sum"
# contrasts(df$Game_Type) <- "contr.sum"
# 
# summary(df)
# ddply(df, ~ Sex * Game_Type, function(data) summary(data$Hours_Played)) # summary report
# ddply(df, ~ Sex * Game_Type, summarise, Hours.mean=mean(Hours_Played), Hours.sd=sd(Hours_Played))
# 
# boxplot(Hours_Played ~ Sex * Game_Type, data=df, xlab="Sex * Game_Type", ylab="Hours_Played") # boxplot
# 
# with(df, interaction.plot(Sex, Game_Type, Hours_Played, ylim=c(0, max(df$Hours_Played)))) # interaction plot
# 
# m = aov(Hours_Played ~ Sex * Game_Type, data=df) # fit an ANOVA model
# shapiro.test(residuals(m)) # test the normality of residuals with Shapiro-Wilk
# qqnorm(residuals(m)); qqline(residuals(m)) # line should be through points
# anova(m)  # or summary(m)
# 
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Sex * Game_Type))), test=adjusted(type="holm")) # compare all pairs (not justified)
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Sex))), test=adjusted(type="holm")) # compare pairs of Sex (same as Sex main effect)
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Game_Type))), test=adjusted(type="holm")) # compare pairs of Game Type
# 
# m = ezANOVA(dv=Hours_Played, between=c(Sex, Game_Type), wid=Subject, data=df) # using ez
# m$ANOVA
# 
# 
# ###
# ### Two-way repeated measures ANOVA, plus
# ###    long -> wide table format,
# ###    descriptive statistics,
# ###    histograms,
# ###    boxplots,
# ###    interaction plots,
# ###    pairwise comparisons,
# ###    ezANOVA
# ###
# df = read.csv("within.csv") # read in data file
# View(df)
# df$Subject = factor(df$Subject)
# contrasts(df$Game_Type) <- "contr.sum"
# contrasts(df$Posture) <- "contr.sum"
# 
# df2 = dcast(df, Subject ~ Game_Type * Posture, value.var="Hours_Played") # go wide (for drill)
# View(df2) # same as df
# 
# summary(df)
# ddply(df, ~ Game_Type * Posture, function(data) summary(data$Hours_Played)) # summary report
# ddply(df, ~ Game_Type * Posture, summarise, Hours.mean=mean(Hours_Played), Hours.sd=sd(Hours_Played))
# 
# hist(df$Hours_Played, xlim=c(0,100), ylim=c(0,15)) # histograms
# hist(df[df$Game_Type == "MMORPG" & df$Posture == "Sit",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# hist(df[df$Game_Type == "MMORPG" & df$Posture == "Stand",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# hist(df[df$Game_Type == "Mystery" & df$Posture == "Sit",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# hist(df[df$Game_Type == "Mystery" & df$Posture == "Stand",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# hist(df[df$Game_Type == "Shooter" & df$Posture == "Sit",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# hist(df[df$Game_Type == "Shooter" & df$Posture == "Stand",]$Hours_Played, xlim=c(0,100), ylim=c(0,4))
# 
# wc = c(df2$MMORPG_Sit, df2$MMORPG_Stand, df2$Mystery_Sit, df2$Mystery_Stand, df2$Shooter_Sit, df2$Shooter_Stand)
# hist(wc, xlim=c(0,100), ylim=c(0,15)) # from the wide-format table, the same histograms
# hist(df2$MMORPG_Sit, xlim=c(0,100), ylim=c(0,4))
# hist(df2$MMORPG_Stand, xlim=c(0,100), ylim=c(0,4))
# hist(df2$Mystery_Sit, xlim=c(0,100), ylim=c(0,4))
# hist(df2$Mystery_Stand, xlim=c(0,100), ylim=c(0,4))
# hist(df2$Shooter_Sit, xlim=c(0,100), ylim=c(0,4))
# hist(df2$Shooter_Stand, xlim=c(0,100), ylim=c(0,4))
# 
# boxplot(Hours_Played ~ Posture * Game_Type, data=df, xlab="Posture * Game_Type", ylab="Hours_Played") # boxplot
# 
# with(df, interaction.plot(Posture, Game_Type, Hours_Played, ylim=c(0, max(df$Hours_Played)))) # interaction plot
# 
# m = aov(Hours_Played ~ Game_Type * Posture + Error(Subject/(Game_Type * Posture)), data=df) # fit ANOVA model
# summary(m)  # show ANOVA
# 
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Game_Type * Posture))), test=adjusted(type="holm")) # all pairwise compairsons
# 
# m = ezANOVA(dv=Hours_Played, within=c(Game_Type, Posture), wid=Subject, data=df) # using ez
# m$ANOVA
# 
# 
# ###
# ### Two-way mixed-factorial ANOVA, plus
# ###    wide -> long table format,
# ###    boxplots,
# ###    interaction plots,
# ###    pairwise comparisons,
# ###    ezANOVA
# ###
# df = read.csv("mixed.csv")
# View(df)
# df$Subject = factor(df$Subject)
# 
# df2 = melt(df, id.vars=c("Subject","Sex"), measure.vars=c("MMORPG", "Mystery", "Shooter"), variable.name="Game_Type", value.name="Hours_Played") # go long
# View(df2)
# df2 = df2[order(df2$Subject),] # sort by Subject
# View(df2)
# contrasts(df2$Sex) <- "contr.sum"
# contrasts(df2$Game_Type) <- "contr.sum"
# 
# boxplot(Hours_Played ~ Game_Type * Sex, data=df2, xlab="Game_Type * Sex", ylab="Hours_Played") # boxplot
# 
# with(df2, interaction.plot(Sex, Game_Type, Hours_Played, ylim=c(0, max(df2$Hours_Played)))) # interaction plot
# 
# m = aov(Hours_Played ~ Sex * Game_Type + Error(Subject/Game_Type), data=df2) # fit ANOVA model
# summary(m)  # show ANOVA
# 
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Sex * Game_Type))), test=adjusted(type="holm")) # not justified
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Game_Type))), test=adjusted(type="holm")) # justified
# 
# boxplot(Hours_Played ~ Game_Type, data=df2, xlab="Game_Type", ylab="Hours_Played") # boxplot
# 
# m = ezANOVA(dv=Hours_Played, within=Game_Type, between=Sex, wid=Subject, data=df2) # using ez
# m$ANOVA
