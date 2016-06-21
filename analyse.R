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


pub_tab <- as.data.frame(table(ss_data$publisher));
pub_tab_gt2    = pub_tab[pub_tab$Freq > 2, ]
pub_tab_ranked = pub_tab_gt2[order(pub_tab_gt2$Freq, decreasing = TRUE), ]

hist(pub_tab_ranked$Freq, breaks=50)
head(pub_tab_ranked,30)
