libname mydir '/home/u62241961/BUMK742/Project 1';


data temp;           
set mydir.tropic;    

lq=log(quant);
lp=log(price);

qrt1=0;
qrt2=0;
qrt3=0;
if (week>=1 and week<=13) or (week>=53 and week<=65) then qrt1=1;
if (week>=14 and week<=26) or (week>=66 and week<=78) then qrt2=1;
if (week>=27 and week<=39) or (week>=79 and week<=91) then qrt3=1;

store1=0;
store2=0;
store3=0;
store4=0;
store5=0;
store6=0;
store7=0;
store8=0;
store9=0;
store10=0;
store11=0;
store12=0;
store13=0;
store14=0;
if (store=2) then store1=1;
if (store=14) then store2=1;
if (store=32) then store3=1;
if (store=52) then store4=1;
if (store=62) then store5=1;
if (store=68) then store6=1;
if (store=71) then store7=1;
if (store=72) then store8=1;
if (store=93) then store9=1;
if (store=95) then store10=1;
if (store=111) then store11=1;
if (store=123) then store12=1;
if (store=124) then store13=1;
if (store=130) then store14=1;

decimal=mod(price,1);
reversed_decimal=reverse(decimal);
final_digit=substr(reversed_decimal,1,1);
end9=0;
if (final_digit=9) then end9=1;

proc reg;
model lq = store1-store14 price deal end9 week qrt1-qrt3;




/*proc means;
var quant price;
class qrt1-qrt3;*/
