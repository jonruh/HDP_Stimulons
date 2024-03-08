library(PCAtools)
library(dplyr)


# PCA of A matrix

logtpmData<-read.csv(file="log_tpm_norm_for_PCA.csv",row.names = 1, check.names = FALSE)
MetaData<-read.csv(file = "metadata_for_PCA.csv", row.names = 1, check.names = FALSE)

logtpmData<- logtpmData %>%mutate_all(as.numeric)
logtpmData <- t(scale(t(logtpmData)))

p <- pca(logtpmData,metadata = MetaData, removeVar = 0.1)

biplot(p,
       x = 'PC1',
       y = 'PC3',
       ntopLoadings = 5,fillBoxedLoadings = "white",widthLoadingsArrows = 1.0,drawConnectorsLoadings = TRUE,
       sizeLoadingsNames = 5.0,
       borderWidth = 1.0,gridlines.minor = FALSE,gridlines.major = FALSE,vlineWidth = 1,hlineWidth = 1,
       colby = "Culture Type",
       shape = "Strain Type",
       colLegendTitle = "Oscillation",
       shapeLegendTitle = "Timepoint",
       hline = 0,
       vline = 0,
       legendPosition = "right",borderColour = "black",
       lab = NULL,
       showLoadings = TRUE)

pairsplot(p,components = c("PC1","PC2","PC3","PC4"))

write.csv(p["loadings"],"log_tpm_PCA_loadings.csv")
write.csv(p["rotated"],"log_tpm_PCA_rotated.csv")
write.csv(p["metadata"],"log_tpm_PCA_metadata.csv")
write.csv(p["variance"],"log_tpm_PCA_variances.csv")

screeplot(p)