# Set working directory to your workspace ...
setwd("/my/workspace/steam-spy-analysis")

# Read data
ss_data = read.csv("output/steamspy_out.csv") 
ss_data


#############
# Article 1 # - Basic stats
#############

# Plot: total ownership of games  -> sharp drop off (example)
# Plot: total ownership of games  -> log(owners) - normal-ish?
# Plot: total playership of games -> log(players) - explain difference 
# Plot: total playtime of games   -> log(playtime) - lovely normal / log normal
# Scatter: owners vs players (log) - explain obv trend; discuss some outliers
# Scatter: players vs playtime (log) - explain core peak + upward tendency

# Histograms
hist(log(ss_data$owners), breaks=100)
hist(log(ss_data$players_forever), breaks=100)
hist(log(ss_data$avg_playtime_forever), breaks=100)   # Beautiful normal distribution!
mean(log(ss_data$owners[ ss_data$owners != 0 ]))

# QQ plot of avg playtime
log_playtime = log(ss_data$avg_playtime_forever)
qqnorm(log_playtime[is.finite(log_playtime)])
qqline(log_playtime[is.finite(log_playtime)], col = 2,lwd=2,lty=2)

# Scatter plots (applying log)
plot(ss_data$owners,
     ss_data$players_forever,
     xlab="owners", 
     ylab="players_forever",
     log = "xy")  

plot(ss_data$players_forever,
     ss_data$avg_playtime_forever,
     xlab="players_forever", 
     ylab="avg_playtime_forever",
     log = "xy")  



# Article 1a - player/owner ratio
# Top PO ratios -> OMSI 2, specialist game
# Plot: PO ratio distribution -> three peaks, three groups?qqP
# Plot: PO ratio vs log(playime) - explain
#   - show frequency distribution
#   - analyse quadrants / outliers (explain one per group)
#   - see if publishers tend to cluster into groups
#   - see if developers tend to cluster into groups
# Plot: PO ratio vs log(playtime) - grouped (???)

ss_data$po_ratio <- ss_data$players_forever / ss_data$owners

ss_data_pos = ss_data[complete.cases(ss_data),]         # Filter out rows with NaN p/o ratio
ss_data_pos = ss_data_pos[ss_data_pos$po_ratio < 1.00,] # Filter out 1.0 and above (noise)
ss_data_pos = ss_data_pos[ss_data_pos$po_ratio > 0.95,] # Focus on top P/O ratio

View(best_po_ratio) # Filter 10k+ owners; sort by owners/playtime/etc

hist(ss_data_pos$po_ratio, breaks=150)

plot(ss_data$avg_playtime_forever,
     ss_data$po_ratio,
     xlab="avg_playtime_forever", 
     ylab="po_ratio",
     log = "x")  



#############
# Article 2 # - top publishers/devs
#############

# Rank publishers by total games
# Rank developers by total games

# Rank publishers by units sold
# Rank developers by units sold

# Calculate average total play time for all publishers
# Calculate average total play time for all developers

# Rank publishers by average total play time
# Rank developers by average total play time
#   - which publishers are the best value for money?
#   - which developers are the best value for money?

# Rank publishers
pub_tab <- as.data.frame(table(ss_data$publisher));
pub_tab_gt2    = pub_tab[pub_tab$Freq > 2, ]
pub_tab_ranked = pub_tab_gt2[order(pub_tab_gt2$Freq, decreasing = TRUE), ]

hist(pub_tab_ranked$Freq, breaks=50)
head(pub_tab_ranked,30)

pub_tab = aggregate(ss_data[,c("owners", "players_forever")], list(Publisher = ss_data$publisher), sum)
pub_tab$count        <- aggregate(ss_data[,c("publisher")], list(Publisher = ss_data$publisher), length)
pub_tab$avg_playtime <- aggregate(ss_data[,c("avg_playtime_forever")], list(Publisher = ss_data$publisher), mean)
#pub_tab$sum_playtime <- aggregate(ss_data[,c("avg_playtime_forever")], list(Publisher = ss_data$publisher), sum)


#############
# Article 3 #
#############

# Plot: average play time vs owners (by publisher / by developer)
#   - which publishers sell well, but for relatively low time played?
#   - which publishers sell poorly, but are played disproportionately?

# Plot: average play time vs owners (by game, group by top 10 pubs / devs)
#   - see if publishers tend to cluster into groups
#   - see if developers tend to cluster into groups



