pressure = linspace(0,620,100)

fit1 = (-3.133-17.6676+21.442).*pressure + (2.2667 -38.54-22.77); 
fit2 = (26.33604).*pressure +(-94.66);

figure
plot(pressure,fit1,pressure,fit2)
legend('fit1','fit2')
xlabel('pressure')
ylabel('force')




%% Comparing parameters of model 4: Sept 7 
% model4 = readmatrix('Model4_Parameters.xlsx');
% state = [1,0];
% 
% %% analyze only 10mm13cm- compare slopes across different kinks
% diameter = 10;
% test=10;
% lengths = [13,27];
% 
% 
% % for j=1:length(lengths)
% %     figure(j)
%     for i=1:length(state)
%         [diameter,lengths(j),lo,li,l620,kink,kmax,testnum,State] = choosedata(diameter,lengths(j),test);
%         data = model4(model4(:,1)==diameter&model4(:,2)==lengths(j)&model4(:,8)==state(i),:);
%         plot(data(:,5),data(:,13))
%         str = sprintf('Slope vs Strain %d%d',lengths(j),state(i))
%         title(str)
%         grid on
%         hold on
%     end
%     hold off
%     legend('pressurizing','depressurizing')
%     
    
%     end
%     legend('Pressurizing','Depressurizing')
% end

































% 10mm 13cm
% pressure = linspace(0,620,100);
% 
% P_yfit10mm13cm_1 = 0.64121*pressure - 59.044; 
% P_yfit10mm13cm_2 = 0.645*pressure -130.74;
% P_yfit10mm13cm_3 = 0.589*pressure - 194.8;
% P_yfit10mm13cm_4 = 0.536*pressure - 231.369;
% 
% DP_yfit10mm13cm_1 = 0.6146*pressure - 52.014; 
% DP_yfit10mm13cm_2 = 0.598*pressure -106.24;
% DP_yfit10mm13cm_3 = 0.5532*pressure - 165.65;
% DP_yfit10mm13cm_4 = 0.429*pressure - 161.69;
% 
% %% 20mm 40cm
% P_yfit20mm40cm_1 = 2.29*pressure -162.54;
% P_yfit20mm40cm_2 = 1.7865*pressure -340.65;
% P_yfit20mm40cm_3 = 1.546*pressure - 344.227;
% P_yfit20mm40cm_4 = 1.106*pressure - 355.3;
% 
% 
% DP_yfit20mm40cm_1 = 2.2619*pressure -153.32;
% DP_yfit20mm40cm_2 = 1.739*pressure -318.90;
% DP_yfit20mm40cm_3 = 1.496*pressure -319.38;
% DP_yfit20mm40cm_4 = 1.0365*pressure -321.19;
% 
% figure
% subplot(221)
% plot(pressure,P_yfit10mm13cm_1,pressure,P_yfit10mm13cm_2,pressure,P_yfit10mm13cm_3,pressure,P_yfit10mm13cm_4);
% title('10mm13cm - Pressure vs Force (P)')
% ylim([0,1000])
% legend
% grid on
% subplot(222)
% plot(pressure,DP_yfit10mm13cm_1,pressure,DP_yfit10mm13cm_2,pressure,DP_yfit10mm13cm_3,pressure,DP_yfit10mm13cm_4);
% title('10mm13cm -Pressure vs Force(DP)')
% ylim([0,1000])
% legend
% grid on
% subplot (223)
% plot(pressure,P_yfit20mm40cm_1,pressure,P_yfit20mm40cm_2,pressure,P_yfit20mm40cm_3,pressure,P_yfit20mm40cm_4);
% title('20mm40cm -Pressure vs Force (P)')
% ylim([0,1000])
% legend
% grid on
% subplot(224)
% plot(pressure,DP_yfit20mm40cm_1,pressure,DP_yfit20mm40cm_2,pressure,DP_yfit20mm40cm_3,pressure,DP_yfit20mm40cm_4);
% title('20mm40cm -Pressure vs Force (P)')
% ylim([0,1000])
% legend
% grid on



