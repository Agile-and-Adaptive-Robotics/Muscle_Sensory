clear; close all;clc
% This script search for all .mat files in the matlab directory and convert
% all data recordings to .csv files with proper BPA parameters

datamat = dir('*.mat'); %find all mat files and save in an array
L = length(datamat);
D = {datamat(1:L).name};
matfile = convertCharsToStrings(D);
expression = '(?<Diameter>[a-zA-Z0-9])+_(?<Length>[a-zA-Z0-9])+_(?<Kink>[a-zA-Z0-9])+';
[names,tokens,matches] = regexp(matfile,expression,'names','tokens','match');

datanames = strings;%checknames=strings;
%Extract the name of the .mat files
for i = 1:L
    if isempty(tokens{1,i})
    else
    datanames(i) = join(tokens{1,i}{1},'_'); %storing data with proper naming
    end
end

%% Load data from .mat file and save as csv using names created
% testnames = ["Offset","Test1Data","Test2Data","Test3Data","Test4Data","Test5Data","Test6Data","Test7Data","Test8Data","Test9Data","Test10Data"];
testnames = ["Test9Data","Test10Data"];

for k =1:length(datanames) %1-8
     for j=1:length(testnames)
        data =load(datanames(k),testnames(j)); %data contains 11 data recordings
        csvname = sprintf('%s_%s.csv',datanames(k),testnames(j))
        str=sprintf('data.%s',testnames(j))
%             if testnames(j)=="Offset"
%                 csvname = sprintf('%s_%s.csv',datanames(k),testnames(j))
%                 str =sprintf('data.%s',testnames(1))
%             else 
%                % str =sprintf('data.%s',testnames(k))
%                 csvname = sprintf('%s_%s.csv',datanames(k),testnames(j))
%                 str=sprintf('data.%s',testnames(j))
%             end
            writematrix(eval(str),csvname)
            clear data
     end

end





