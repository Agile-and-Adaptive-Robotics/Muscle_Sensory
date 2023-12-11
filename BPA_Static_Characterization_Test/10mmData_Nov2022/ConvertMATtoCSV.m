%Load Mat files into MATLAB workspace (10mm - Jan 2023)

clear; close all; clc;
diameter = 10;
lengths_10mm = [10,15,20,25,30,40,52];
kink = {'Unkink','kinked25','kinked50','kinked75'};
testname = ["Offset","Test8Data","Test9Data","Test10Data"];
testn = ["Offset","Test8","Test9","Test10"];

for c = 1:length(lengths_10mm)
    for b = 1:length(kink)
        file_names_mat  = sprintf('%dmm_%dcm_%s.mat',diameter,lengths_10mm(c),kink{b});
        file_names = sprintf('%dmm_%dcm_%s',diameter,lengths_10mm(c),kink{b});
        data = load(file_names_mat);
        s = fields(data);
        tf = matches(testname,s);
       for d = 1:length(testname)
           if tf(d)==1
%               g{d}=getfield(data,testname(d)); 
              writematrix(data.(testname(d)),sprintf('%s_%s.csv',file_names,testn(d)))        
           else
           end
       end
    end
end


length_45 = 45;
kink45 = 'Unkink';
file_name = sprintf('%dmm_%dcm_%s',diameter,length_45,kink45);
file_name_mat = sprintf(file_name,'.mat');
dat = load(file_name_mat);
csvwrite(sprintf('%s_Offset.csv',file_name),dat.Offset)        
csvwrite(sprintf('%s_Test8.csv',file_name),dat.Test8Data)
csvwrite(sprintf('%s_Test9.csv',file_name),dat.Test9Data)
csvwrite(sprintf('%s_Test10.csv',file_name),dat.Test10Data)




