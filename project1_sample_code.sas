/* Sample Program for Project 1: Pricing Models  */
/* The key SAS learning objective is to estimate */
/* linear and linearizable models using PROC REG.  */

/* The LIBNAME statement creates the library name for the file folder where */
/* the SAS data file "tropic.sas7bdat" is located in my file folder on the server. */
/* You need to modify the path according to the file folder under your account. */
/* Note that the LIBNAME statement below is for SAS OnDemand for Academics, */
/* and the commented-out line underneath it is the version for SAS in Windows. */  

libname mydir '/home/jiejie0/BUSM710/Project1';
*libname mydir 'C:\0jie\BUMK706\Assignments\Project1';

data temp;            /* You can give any name for the temporary data file */
set mydir.tropic;     /* load the SAS data file 'tropic.sas7bdat' */

/* Create log-transformation of sales and price */
lq=log(quant);
lp=log(price);

/* Create three dummy variables for the four quarters */
/* treating the fourth quarter as the baseline */
qrt1=0;
qrt2=0;
qrt3=0;
if (week>=1 and week<=13) or (week>=53 and week<=65) then qrt1=1;
if (week>=14 and week<=26) or (week>=66 and week<=78) then qrt2=1;
if (week>=27 and week<=39) or (week>=79 and week<=91) then qrt3=1;

/* Get frequency table of DEAL and STORE */
proc freq;
table deal store;

/* Get descriptive statistics of sales and price */
proc means;
var quant price;

/* Get average sales volume by store */
proc means;
var quant;
class store;

/* Get correlation matrix of sales, price, week, and deal */
proc corr;
var quant price week deal;

/* Estimate alternative models in the following proc reg statement */
proc reg;
model quant = price deal;    /* linear model */
model lq = lp deal;            /* log-log model */
model lq = lp deal qrt1 qrt2 qrt3;  /* log-log models */
model lq = price deal;             /* semi-log models */
model lq = price deal qrt1 qrt2 qrt3;   /* semi-log models */
run; 
