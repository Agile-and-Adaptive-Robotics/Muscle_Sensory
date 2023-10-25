% Pam Data
% Author: Connor Morrow
% Date: 11/16/2020
% Description: This script allows for creating reusable classes, which 
% categorize and calculates BPA information. This will be used to convert
% testing data into a more usable form.

%Refer to https://www.mathworks.com/help/matlab/matlab_oop/example-representing-structured-data.html

classdef BPAclass < handle
    
    %% ------------Public Properties---------------------------
    %List of explicit properties for the muscles
    properties
        diameter                    %Name of the muscle
        Location
        Cross                       %Designates which row corresponds with a location where the muscle crosses into a new reference frame
        Diameter                    %Diameter of the BPA
        TransformationMat           %Contains a transformation matrix to change the 
        RestingL                    %Resting Length of the muscle
        Kmax                        %Length of BPA at maximum contraction
        FittingLength               %Length of each end cap (center of hole to bottom port)
        TendonL                     %Length of tendon, if any
        Pressure                    %Pressure of BPA
    end
    
    %Dependent properties are those that are calculated by the explicit
    %properties. Matlab will not calculate these until it is queried in the
    %main script
    properties (Dependent)   
        SegmentLengths
        LongestSegment
        MuscleLength
        Contraction
        LengthCheck
        UnitDirection
        MomentArm
        Fmax620
        Force
        Torque
    end
    
    methods
        function obj = untitled(inputArg1,inputArg2)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

