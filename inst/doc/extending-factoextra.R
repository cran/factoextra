## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  # Backend templates are illustrative by default. The self-contained base-R
  # quick starts opt in to evaluation below.
  eval = FALSE
)

## ----quick-start-prcomp, eval=TRUE, fig.alt="PCA biplot, scree plot, and contribution plot created through the factoextra constructor"----
library(factoextra)

# A base-R PCA (any analysis that yields coordinates would do)
pca <- prcomp(iris[, -5], scale. = TRUE)

# Wrap the coordinates into a factoextra-ready object
res <- as_factoextra_pca(
  ind.coord = pca$x,
  var.coord = sweep(pca$rotation, 2, pca$sdev, "*"),
  eig       = pca$sdev^2,
  scale.unit = TRUE
)

# Now the full fviz_pca_* family works on `res`
fviz_pca_biplot(res, label = "var", habillage = iris$Species,
                addEllipses = TRUE)
fviz_eig(res)
fviz_contrib(res, choice = "var", axes = 1)

## ----quick-start-mds, eval=TRUE, fig.alt="Classical multidimensional-scaling coordinates plotted with factoextra"----
mds <- stats::cmdscale(dist(scale(mtcars)), k = 3)   # classical MDS (eigen-based)
fviz_pca_ind(as_factoextra_pca(ind.coord = mds), repel = TRUE)

## ----umap-face, eval=FALSE----------------------------------------------------
# set.seed(123)
# um <- uwot::umap(iris[, 1:4])
# fviz_umap(um, habillage = iris$Species, addEllipses = TRUE)
# fviz_umap(um, col.ind = iris$Petal.Length)   # colour by a continuous feature value

## ----exposition-example, eval=FALSE-------------------------------------------
# library(ExPosition)
# library(factoextra)
# 
# res.pca <- epPCA(iris[, -5], graph = FALSE)
# fviz_pca_ind(res.pca, habillage = iris$Species, addEllipses = TRUE)
# fviz_eig(res.pca)
# fviz_contrib(res.pca, choice = "var")

