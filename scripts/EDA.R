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
mydir <- file.path(Sys.getenv("MDLIDE_WORKSPACE_HOME"),"Workflow_warf_base","models")
setwd(mydir)

#' Set name of .mdl file and dataset for future tasks
uc <- "UseCase2"
datafile <- "warfarin_conc.csv"
mdlfile <- paste0(uc,".mdl")

#' Create a new folder to be used as working directory and where results will be stored
wd <- file.path(mydir,"Step0")
dir.create(wd)

#' Exploratory Data Analysis
#' =========================
#' Use 'ddmore'  function getDataObjects() to retrieve only data object(s) from an existing .mdl file
#' This function returns a list of Parameter Object(s) from which we select the first element
#' Hover over the variable name to see its structure
myDataObj <- getDataObjects(mdlfile)[[1]]

#' Recall that getDataObjects only reads the MDL code from the .mdl file.
#' Use 'ddmore' function readDataObj() to create an R object from the MDL data object.
#+ Exploratory Data Analysis
myData <- readDataObj(myDataObj)

#' Extract only observation records
myEDAData<-myData[myData$MDV==0,]

#' Export the results in png files
filePath <- file.path(mydir,"Step0")
fileName <- paste0(filePath,"/Step0_EDA_%d.png")

png(fileName)
#' Plot the data using xyplot from the lattice library 
xyplot(DV~TIME,groups=ID,data=myEDAData,type="b",ylab="Conc. (mg/L)",xlab="Time (h)")
xyplot(DV~TIME|as.factor(ID),data=myEDAData,type="b",layout=c(3,4),ylab="Conc. (mg/L)",xlab="Time (h)",scales=list(relation="free"))
dev.off()

