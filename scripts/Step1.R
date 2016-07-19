#' Illustrative workflow using the warfarin Pop PK model
#' ==========================================================================
#' UseCase2 : Warfarin population pharmacokinetics model with analytical solutions
#' ------------------------------------------------------------------------
#' Step 1 - Exploratory Data Analysis

#' Initialisation
#' =========================
#+ Initialisation
#' Clear workspace and set working directory under 'UsesCasesDemo' project
rm(list=ls(all=F))

#' Set name of .mdl file and dataset for future tasks
uc <- "Step1"
datafile <- "warfarin_conc.csv"
mdlfile <- paste0(uc,".mdl")

mydir <- file.path(Sys.getenv("MDLIDE_WORKSPACE_HOME"),"Workflow_warf_base","models")
setwd(mydir)

#' Model Development
#' =========================

#' ESTIMATE model parameters using Monolix
#' -------------------------
#' The ddmore "estimate" function translates the contents of the .mdl file to 
#' a target language and then estimates parameters using the target software. After estimation, 
#' the output is converted to a Standard Output object which is saved in a .SO.xml file.
#'   
#' Translated files and Monolix output will be returned in the ./Monolix subfolder.
#' The Standard Output object (.SO.xml) is read and parsed into an R object called "mlx" 
#' of (S4) class "StandardOutputObject".
#+ Monolix Estimation
mlx <- estimate(mdlfile, target="MONOLIX", subfolder=uc)

#' Perform model diagnostics for the base model using Xpose functions 

#' Use 'ddmore' function as.xpdb() to create an Xpose database object from
#' the Standard Output object, regardless of target software used for estimation.
#+ GOF for Monolix Estimation
mlx.xpdb<-as.xpdb(mlx,datafile)

#' We can then call Xpose functions referencing this mlx.xpdb object as the input. 
#' Perform some basic goodness of fit (graphs are exported to PNG files)

png(file.path(mydir,uc,"GOF_MLX_%d.png"))
 print(basic.gof(mlx.xpdb))
 print(ind.plots(mlx.xpdb))
dev.off()