# Spurdog Exercise Data

This dataset provides inputs for constructing an **age-structured population model** using a **Leslie matrix**. The data includes natural and fishing mortality rates, as well as fecundity estimates by age class.

## 📂 Files Provided
| File Name                     | Description |
|--------------------------------|-------------|
| **`Mortality_data.csv`**       | Natural and fishing mortality rates by age class, with precomputed survival probabilities. |
| **`Fecundity_by_age_exercise.csv`** | Fecundity-related parameters by age class. |
| **`spurdog_life_table.csv`** | Aligned life-history parameters. |

---

## 📊 Dataset Descriptions

### 🔹 `Mortality_data.csv`
This file contains **instantaneous mortality rates**, which must be **converted to survival probabilities** before use in a Leslie matrix. To assist with this, **precomputed survival probabilities** have been provided.

| Column Name   | Description |
|--------------|-------------|
| `age`        | Age class (integer, starting from 1). |
| `natural_mort` | Instantaneous natural mortality rate. |
| `fishing_mort` | Instantaneous fishing mortality rate. Fishing only occurs between ages **5 and 30**, but you may choose to alter this range. |
| `total_mort` | Sum of natural and fishing mortality rates. |
| `survival_prob` | Pre-calculated survival probability \( S = e^{-(M + F)} \). |

---

### 🔹 `Fecundity_by_age_exercise.csv`
This file provides **fecundity-related parameters** but requires calculations to determine final fecundity values to put into the Leslie matrix.

| Column Name           | Description |
|-----------------------|-------------|
| `age_class`          | Age class (integer values **1-26, plus "27+"**). The `"27+"` group indicates that fecundity remains **constant** for older individuals. |
| `females_mature`     | Proportion of individuals mature at this age. |
| `pups_per_mat_female` | Number of pups produced per mature female. |
| `fecundity_F`        | **To be calculated.** This must account for **maturity, gestation length (24 months), and sex ratio (50 % female pups).** |

### 🔹 `spurdog_life_table.csv`

The file **spurdog_life_table.csv** is generated by merging information from the two source files:
- **Mortality_data.csv**
- **Fecundity_by_age_exercise.csv**

It includes the following columns:

- **`a`**: This column represents the age class, re-indexed so that the original age (which starts at 1 in Mortality_data.csv) is adjusted to begin at 0. This adjustment ensures that age 0 corresponds to the first age class (0–1 year) in the Leslie matrix.
- **`S_a`**: The survival probability for each age class, taken directly from Mortality_data.csv.
- **`b_a`**: The adjusted fecundity rate for each age class. This value is calculated from the fecundity parameters (such as proportion mature and pups per mature female) and is further adjusted by dividing by 4 to account for a 2-year gestation period and a 1:1 sex ratio.

This realignment should make it clearer to see that the fecundity rates apply at the start of that age class, and survival probabilities apply through it. In the Leslie matrix, the top row (fecundity row) is populated with the **F_a** values, and the sub-diagonal is filled with the **S_a** values. You would still therefore need to calculate **F_a**, adjusting for survival between age classes before pupping (births). |

---
## 📌 Data Provenance  

The fecundity and mortality data provided in this repository are derived from **published literature and stock assessments** for Northeast Atlantic spurdog (*Squalus acanthias*).  

- **Fecundity estimates** were adapted from **ICES Working Group on Elasmobranch Fishes (WGEF) reports (2010–2014)**, **Jones & Ugland (2001)**, and **Hickling (1930)**. These sources provided length-based pup production data and female maturity at age.  
- **Natural mortality rates** were sourced from **ICES assessments** and converted to **age-specific values** using the observed age-size relationships in sampled bycatch.  
- **Fishing mortality rates** were based on **ICES WGEF estimates**, assuming a mean fishing mortality of **0.014 for age classes 5–30**, derived from reported landings.  

### 📖 References  

**ICES (2010–2014).** *Reports of the Working Group on Elasmobranch Fishes (WGEF).* International Council for the Exploration of the Sea (ICES), Copenhagen.  

**Jones, T.S. & Ugland, K.I. (2001).** ‘Reproduction of female spiny dogfish, *Squalus acanthias*, in the Oslofjord’, *Fishery Bulletin*, **99**(4), pp. 685–690.  

**Hickling, C.F. (1930).** ‘A contribution towards the life-history of the spur-dog’, *Journal of the Marine Biological Association of the United Kingdom (New series)*, **16**(2), pp. 529–576.  
