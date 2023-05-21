# Step 1: Read the genotype data from the TPED file
genotype_data <- read.table("C:/Users/anuba/Downloads/beagle_gwas_extremes_1.tped", header = FALSE, sep = "\t")

# Step 2: Calculate the allele frequencies for each SNP
allele_freq <- apply(genotype_data[, 5:ncol(genotype_data)], 1, function(x) {
  alleles <- unlist(strsplit(as.character(x), ""))
  allele_count <- table(alleles)
  freq <- allele_count / sum(allele_count)
  freq
})

# Step 3: Create a new data frame with the desired output format
output_df <- data.frame(
  chromosome = genotype_data[, 1],
  position = genotype_data[, 4],
  snp_id = genotype_data[, 2],
  allele_1 = unlist(lapply(allele_freq, function(x) names(x)[1])),
  allele_2 = unlist(lapply(allele_freq, function(x) names(x)[2])),
  freq_allele_1 = unlist(lapply(allele_freq, function(x) x[1])),
  freq_allele_2 = unlist(lapply(allele_freq, function(x) x[2]))
)

# Step 4: Order the SNP data by chromosome and within chromosome by position
output_df <- output_df[order(output_df$chromosome, output_df$position), ]

# Step 5: Move the sex chromosomes and mitochondrial chromosomes to the bottom
custom_order <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "X", "Y", "MT")
output_df$chromosome <- factor(output_df$chromosome, levels = custom_order)
output_df <- output_df[order(output_df$chromosome), ]

# Step 6: Print the resulting data frame
print(output_df)
