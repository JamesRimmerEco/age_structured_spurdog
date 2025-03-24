# -------------------------------
# Spurdog Life Table Generator
# -------------------------------
# This script creates a life table for spurdogs by combining mortality and fertility data.
# It assumes that 'mort_data' is already loaded in your workspace with the following columns:
#   a            : Age index from 1 to 61 (where a=1 corresponds to age 0-1, a=2 to 1-2, etc.)
#   survival_prob: Probability of surviving from the current age to the next
#
# Fertility (bₐ) is defined for ages 9 and older using the following schedule:
#   Ages 9 to 11  : 25% mature, 4 pups
#   Ages 12 to 14 : 30% mature, 7 pups
#   Ages 15 to 17 : 55% mature, 8 pups
#   Ages 18 to 20 : 70% mature, 10 pups
#   Ages 21 to 26 : 80% mature, 11 pups
#   Ages 27+     : 100% mature, 11 pups
#
# After accounting for a 2-year gestation and a 1:1 sex ratio, each calculated fertility value is divided by 4.
#
# The final CSV ("spurdog_life_table.csv") will have the following three columns:
#   a  : Age class (starting at 0)
#   S_a  : Survival probability from mort_data
#   b_a  : Adjusted fertility rate


library(dplyr)
mort_data <- read.csv("Mortality_data.csv", stringsAsFactors = FALSE) %>%
  rename(a = age)

# ---- Adjust Age Index ----
# Convert the age index so that a = 1 becomes age 0, a = 2 becomes age 1, etc.
mort_data$age <- mort_data$a - 1

# Create the age vector (should be 0 to 60 if there are 61 rows)
ages <- mort_data$age

# ---- Build Fertility Data (b_a) ----
# Initialise fertility values to zero for all ages
b_a <- rep(0, length(ages))

# For ages 9 to 11: 25% mature, 4 pups -> (0.25 * 4) / 4 = 0.25
b_a[ages >= 9 & ages <= 11] <- (0.25 * 4) / 4

# For ages 12 to 14: 30% mature, 7 pups -> (0.30 * 7) / 4 = 0.525
b_a[ages >= 12 & ages <= 14] <- (0.30 * 7) / 4

# For ages 15 to 17: 55% mature, 8 pups -> (0.55 * 8) / 4 = 1.1
b_a[ages >= 15 & ages <= 17] <- (0.55 * 8) / 4

# For ages 18 to 20: 70% mature, 10 pups -> (0.70 * 10) / 4 = 1.75
b_a[ages >= 18 & ages <= 20] <- (0.70 * 10) / 4

# For ages 21 to 26: 80% mature, 11 pups -> (0.80 * 11) / 4 = 2.2
b_a[ages >= 21 & ages <= 26] <- (0.80 * 11) / 4

# For ages 27 and older: 100% mature, 11 pups -> (1.00 * 11) / 4 = 2.75
b_a[ages >= 27] <- (1.00 * 11) / 4

# ---- Create Life Table Data Frame ----
life_table <- data.frame(
  a = ages,                
  S_a = mort_data$survival_prob,  
  b_a = b_a                  
)

# ---- Write to CSV ----
write.csv(life_table, "spurdog_life_table.csv", row.names = FALSE)

