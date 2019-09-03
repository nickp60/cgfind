# This script is run to recreate the subset of sthe Prokaryotes.txt file used
# by cgfind.
print("Downloading the most updated data from NCBI")
raw <- read.csv("ftp://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/prokaryotes.txt", header=T, sep="\t", stringsAsFactors=FALSE)
proks <- raw[grepl("Complete", raw$Status), ]

# proks_repr <- read.csv2("ftp://ftp.ncbi.nlm.nih.gov/genomes/GENOME_REPORTS/prok_representative_genomes.txt", header=T, sep="\t", stringsAsFactors=FALSE)
# proks_repr <- proks_repr[proks_repr$X.Species.genus != "", ]
print("Parsing data")
proks$genus <- gsub("(.*?) (.*?) (.*)", "\\1", proks$X.Organism.Name)
proks$species <- gsub("(.*?) (.*?) (.*)", "\\2", proks$X.Organism.Name)
proks$acc <- gsub("(.*?)[/;](.*)", "\\1",
     gsub("chromosome.*?:", "", proks$Replicons))

proks$full_ftp <- paste0(proks$FTP.Path, "/",
                         basename(proks$FTP.Path), "_genomic.fna.gz")

colnames(proks)[1] <- "name"
for (thing in c("Status", "WGS", "Group", "SubGroup", "BioProject.Accession", "BioSample.Accession", "BioProject.ID", "Pubmed.ID", "Center", "Proteins", "Strain", "TaxID", "FTP.Path", "Replicons")){
  proks[ , thing] <- NULL
  print(object.size(proks))
}
print("Writing out results")
write.csv(x = proks, file = paste0("new_complete_genomes_min.csv"))
