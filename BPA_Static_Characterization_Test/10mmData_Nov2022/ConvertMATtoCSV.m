%Load Mat files into MATLAB workspace (10mm - Jan 2023)

clear; close all; clc;
diameter = 10;
lengths_10mm = [10,15,20,25,30,40];
kink = {'Unkink','kinked25','kinked50','kinked75'}
kink_percentage = [0,25,50,75];
testnum = [8,9,10];


for c = 1:length(lengths_10mm)
    for b = 1:length(kink)
        file_names_mat  = sprintf('%dmm_%dcm_%s.mat',diameter,lengths_10mm(c),kink{b})
        file_names = sprintf('%dmm_%dcm_%s',diameter,lengths_10mm(c),kink{b})
        data = load(file_names_mat)
        lengths_10mm(c)
        kink(b)
        csvwrite(sprintf('%s_Offset.csv',file_names),data.Offset)        
        csvwrite(sprintf('%s_Test8.csv',file_names),data.Test8Data)
        csvwrite(sprintf('%s_Test9.csv',file_names),data.Test9Data)
        csvwrite(sprintf('%s_Test10.csv',file_names),data.Test10Data)
    end
end







