#Presentation Script
#November 7, 2018
#AMP

#install.packages("BiocManager")
#BiocManager::install(c("GenomicRanges", "Organism.dplyr"))

#Bioconductor is a collection of R packages for the analysis and comprehension of high-throughput genomic data. Bioconductor started more than 10 years ago. It gained credibility for its statistically rigorous approach to microarray pre-processing and analysis of designed experiments, and integrative and reproducible approaches to bioinformatic tasks. There are now more than 600 Bioconductor packages for expression and other microarrays, sequence analysis, flow cytometry, imaging, and other domains. 

data(package = .packages(all.available = TRUE))
library(affy)

install.packages("LearnBioconductor_0.1.6.tar.gz", repos=NULL)

# volcano plot?

#takes advantage of replicates to do more rigorous testing on your data
# need technical replicates
#each point on the plot represents 1 peptide at one time point (small collection of amino acids)
# y-axis= -log(pvalue) top of the plot = significant values helps to spread out the values on the graph by using log, then use the negative to put the most significant ones at the top of the plot
# lines=cutoff p-value 
#vertical bars - technical replicates come into play here - find replicate variance across all of your data. replicate noise is in between those bars, so even though p-value is significant, difference measured between those points might just be replicate noise. 
#Two tests at once: p-value, is the difference bigger than the replicate differences across all of the data?
#p-value - how tightly clustered is your data
#and show effect size