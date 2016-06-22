# Set working directory to your workspace ...
setwd("/my/workspace/steam-spy-analysis")

# Read and display data
ss_data = read.csv("output/steamspy_out.csv") 
ss_data

plot(ss_data$players_forever,
     ss_data$avg_playtime_forever,
     xlab="players_forever", 
     ylab="avg_playtime_forever",
     log = "xy")  

plot(ss_data$owners,
     ss_data$players_forever,
     xlab="owners", 
     ylab="players_forever",
     log = "xy")  

# Display the histogram of player / owner ratios
ss_data$po_ratio <- ss_data$players_forever / ss_data$owners
hist(ss_data$po_ratio, breaks=150)

# Get the most highly played games, according to this data set
best_po_ratio = ss_data[ order(ss_data$po_ratio, decreasing = TRUE), ]
best_po_ratio = best_po_ratio[best_po_ratio$po_ratio < 1.01,]
head(best_po_ratio[,c("appid","name","po_ratio","players_forever","owners")], 200)
# OMSI 2 -> high ratio, specialist game!

# Create table of ranked publishers
pub_tab <- as.data.frame(table(ss_data$publisher));
pub_tab_gt2    = pub_tab[pub_tab$Freq > 2, ]
pub_tab_ranked = pub_tab_gt2[order(pub_tab_gt2$Freq, decreasing = TRUE), ]

hist(pub_tab_ranked$Freq, breaks=50)
head(pub_tab_ranked,30)

# Histogram of average play times (log)
# Beautiful normal distribution
hist(log(ss_data$avg_playtime_forever))

