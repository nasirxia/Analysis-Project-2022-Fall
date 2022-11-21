/* Sample Program for Project 2  */
/* The key SAS learning objective is to estimate generalized linear models */
/* using PROC GENMOD. Specifically, Poisson regressions and Binary logit models */
/*                                               */
/* Components of analyses:                       */ 
/*1. Descriptive statistics and data exploration */
/*2. Estimating Poisson regression model    */
/*3. Estimating Binary Logit Model   		*/


/* Define the library name first in order to locate the data file. */
/* You need to change the path according to the folder on your computer. */
/* Note that the LIBNAME statement below is for the SAS OnDemand for Academics, */
/* and the commented-out line underneath it is the version for SAS in Windows. */  

libname proj2 '/home/u62241961/BUMK742/Project 2';

data temp;    /* You can give any name for the temporary data file */
set proj2.printads;



/* create a dummy variable for the L'Oreal ad */
/* Because the variable BRAND is a character variable, we need to use the */
/* quotation marks when referring to specific values of it, LOreal in this case */
if brand='LOreal' then loreal=1;
else loreal=0;

/* Get descriptive stats */
proc means;
var brand_fix pic_fix brand_size pic_size page_num; /* list any variables you are interested */

/* Get correlation matrix */
proc corr;
var brand_fix pic_fix brand_size pic_size page_num; 

/* Get a list of all brand names via frequency tabulation */
proc freq;
table brand;

/* Poisson Regression Models */

/* For BRAND_FIX: fixation counts of the brand element */ 
proc genmod data=temp;
     model brand_fix=brand_size page_pos page_num loreal/
           dist=poisson link=log;
     title 'Poission Regression for brand fixation count';

/* For PIC_FIX: fixation counts of the pictorial element */ 
proc genmod data=temp;
     model pic_fix=pic_size page_pos page_num loreal/
           dist=poisson link=log;
     title 'Poission Regression for pictorial fixation count';

/* Binary Logit Model */
/* (Note that this model is also called logistic regression. */
/* In SAS, you can also estimate this model using another    */
/* procedure which is specific for logistic regressions.) */ 
/* Important note:           */
/* By default, SAS estimates the probability that Y=the lower value, */
/* which is RECALL_ACCU = 0 in our case. */
/* Need to specify DESCENDING in the PROC GENMOD statement for SAS */
/* to estimate the probability RECALL_ACCU=1 */

proc genmod data=temp descending;
     model recall_accu=brand_fix pic_fix page_pos page_num loreal/
	       dist=binomial link=logit;
     title 'Binary Logit Model for Recall Accuracy = 1';
     
     
proc reg;
model RECALL_TIME=brand_fix pic_fix page_pos page_num;


run;
