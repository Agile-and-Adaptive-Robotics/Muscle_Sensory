checkcsv = dir('*.csv'); %save all .csv files in a structure
length(checkcsv); %count how many csv files in the directory


%Locating all csv files in folder (/AllData_raw_csv)
BPA10mm_csv = dir('10mm*.csv'); length(BPA10mm_csv) 
BPA20mm_csv = dir('20mm*.csv'); length(BPA20mm_csv)



%Check lengths (number of data recordings) of each diameter BPA:
%10mm|20mm|40mm
BPA10mm_lengths = ["13cm","23cm","27cm","29cm","30cm"];
BPA20mm_lengths = ["10cm","12cm","23cm","30cm","40cm"];



csv_10mm_13cm = dir('10mm_13cm*')
length(csv_10mm_13cm);
% csv_10mm_23cm
% csv_10mm_27cm
% csv_10mm_29cm
% csv_10mm_30cm



