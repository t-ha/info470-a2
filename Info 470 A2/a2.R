df = read.csv("master.csv")

df$Participant = factor(df$Participant)
df$Trial = factor(df$Trial)
contrasts(df$Sex) <- "contr.sum"
contrasts(df$Posture) <- "contr.sum"
contrasts(df$Trial) <- "contr.sum"

# View(df)

# plots

# histograms
par(mfrow=c(2,2))
# hist(df$AdjWPM, xlim=c(0,200), ylim=c(0,70), breaks=20) # histograms
hist(df[df$Sex == "M",]$AdjWPM, xlim=c(0,200), ylim=c(0,40), breaks=20, xlab="Adjusted Words Per Minute", main="Male")
hist(df[df$Sex == "F",]$AdjWPM, xlim=c(0,200), ylim=c(0,40), breaks=20, xlab="Adjusted Words Per Minute", main="Female")
hist(df[df$Posture == "sit",]$AdjWPM, xlim=c(0,200), ylim=c(0,40), breaks=20, xlab="Adjusted Words Per Minute", main="Sitting")
hist(df[df$Posture == "stand",]$AdjWPM, xlim=c(0,200), ylim=c(0,40), breaks=20, xlab="Adjusted Words Per Minute", main="Standing")

# boxplots
par(mfrow=c(1,2))
boxplot(AdjWPM ~ Sex, data=df, xlab="Sex", ylab="Adjusted Words Per Minute")
boxplot(AdjWPM ~ Posture, data=df, xlab="Posture", ylab="Adjusted Words Per Minute")

# interaction plot
par(mfrow=c(1,1))
with(df, interaction.plot(Sex, Posture, AdjWPM, ylim=c(86, 96), main="Interaction Plot of Sex & Posture on Adjusted Words Per Minute"))


# conduct the mixed-factorial ANOVA
m = aov(AdjWPM ~ Sex * Posture + Error(Participant/Posture), data=df)
summary(m)

# if the interaction was significant, this would be the pairwise comparison code
# summary(as.glht(pairs(lsmeans(m, pairwise ~ Sex * Posture))), test=adjusted(type="holm"))