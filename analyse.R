# Set working directory to your workspace ...
setwd("/my/workspace/steam-spy-analysis")

# Read data
ss_data = read.csv("output/steamspy_out.csv") 
ss_data

# Basic histograms
hist(log(ss_data$owners), breaks=100)
hist(log(ss_data$players_forever), breaks=100)
hist(log(ss_data$avg_playtime_forever), breaks=50)   # Beautiful normal distribution!
mean(log(ss_data$owners[ ss_data$owners != 0 ]))

# Basic scatter plots (applying log)
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

# Analyse player/owner ratios (candidate top value games)
ss_data$po_ratio <- ss_data$players_forever / ss_data$owners
ss_data_pos = ss_data[complete.cases(ss_data),]     # Filter out rows with NaN p/o ratio
hist(ss_data_pos$po_ratio, breaks=150)

best_po_ratio = ss_data_pos[ order(ss_data_pos$po_ratio, decreasing = TRUE), ]
best_po_ratio = best_po_ratio[best_po_ratio$owners > 10000,]
best_po_ratio = best_po_ratio[best_po_ratio$po_ratio < 1.00,]
best_po_ratio = best_po_ratio[best_po_ratio$po_ratio > 0.95,]
best_po_ratio[ order(best_po_ratio$avg_playtime_forever, decreasing = TRUE), ]

# OMSI 2 -> high ratio, specialist game!

plot(ss_data$avg_playtime_forever,
     ss_data$po_ratio,
     xlab="avg_playtime_forever", 
     ylab="po_ratio",
     log = "x")  


# Rank publishers
pub_tab <- as.data.frame(table(ss_data$publisher));
pub_tab_gt2    = pub_tab[pub_tab$Freq > 2, ]
pub_tab_ranked = pub_tab_gt2[order(pub_tab_gt2$Freq, decreasing = TRUE), ]

hist(pub_tab_ranked$Freq, breaks=50)
head(pub_tab_ranked,30)


