# Set working directory to your workspace ...
setwd("/my/workspace/steam-spy-analysis")

# Read and display data
ss_data = read.csv("output/steamspy_out.csv") 
ss_data

plot(ss_data$players_forever, 
     ss_data$avg_playtime_forever,
     xlab="Players forever", 
     ylab="Avg. playtime forever")  
