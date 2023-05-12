clear; close all;clc
% This script search for all .mat files in the matlab directory and convert
% all data recordings to .csv files with proper BPA parameters

datamat = dir('*.mat'); %find all mat files and save in an array


datanames = strings;%checknames=strings;
%Extract the name of the .mat files
for i = 1:length(datamat)
    matfilenames(i) = convertCharsToStrings(datamat(i).name);
    filenames(i,1:6) = regexp(matfilenames(i),'[a-zA-Z0-9]+','match');;%extracting BPA parameters 
    diameter(i) = filenames(i,2);
    BPAlength(i) = filenames(i,3);
    kink(i) = filenames(i,4);
        % checknames(i,:) = regexp(matfilenames(i),'_[a-zA-Z0-9]+_[a-zA-Z0-9]+_[a-zA-Z0-9]+_','match')
          % convertnames(i,:)=regexp(checknames(i),'[a-zA-Z0-9]+_[a-zA-Z0-9]+_[a-zA-Z0-9]+','match')
    datanames(i) = sprintf('%s_%s_%s',diameter(i),BPAlength(i),kink(i)); %storing data with proper naming
end

%% Load data from .mat file and save as csv using names created
testnames = ["Offset","Test1Data","Test2Data","Test3Data","Test4Data","Test5Data","Test6Data","Test7Data","Test8Data","Test9Data","Test10Data"];

for k =1:length(datanames) %1-8
  data =load(datamat(k).name); %data contains 11 data recordings

     for j=1:length(testnames)
        %csvname = sprintf('%s_%s',BPAparameters,testnames(j))
            if testnames(j)=='Offset'
                csvname = sprintf('%s_%s.csv',datanames(k),testnames(j))
                str =sprintf('data.%s',testnames(1))
            else 
               % str =sprintf('data.%s',testnames(k))
                csvname = sprintf('%s_%s.csv',datanames(k),testnames(j))
                str=sprintf('data.%s',testnames(j))
            end
            csvwrite(csvname,eval(str))
     end

end





