%% Upload Data and plot
Data_10mm_13cm_Unkinked_Test9 = csvread('10mm_13cm_Unkinked_Test9.csv');
    Force_10mm_13cm_Unkinked_Test9_Wrong = Data_10mm_13cm_Unkinked_Test9(:,1);
    Force_10mm_13cm_Unkinked_Test9_A0=((Force_10mm_13cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_13cm_Unkinked_Test9_Offset = Force_10mm_13cm_Unkinked_Test9_A0 - min(Force_10mm_13cm_Unkinked_Test9_A0);
    Force_10mm_13cm_Unkinked_Test9 = (((Force_10mm_13cm_Unkinked_Test9_Offset)*0.1535)-1.963)*4.45; %corrected Force output (N)
    Pressure_10mm_13cm_Unkinked_Test9 =Data_10mm_13cm_Unkinked_Test9(:,2);
    Time_10mm_13cm_Unkinked_Test9 = Data_10mm_13cm_Unkinked_Test9(:,3);

  figure
    sgtitle('10mm 13cm BPA Static Pressure and Force')
    yyaxis left
    plot(Time_10mm_13cm_Unkinked_Test9,Force_10mm_13cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_13cm_Unkinked_Test9,Pressure_10mm_13cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off   
 figure
    title('Pressure vs Force')
    plot(Pressure_10mm_13cm_Unkinked_Test9,Force_10mm_13cm_Unkinked_Test9)
    ylabel('Force(N)')
    xlabel('Pressure(kPa)')

Data_10mm_23cm_Unkinked_Test9 = csvread('10mm_23cm_Unkinked_Test9.csv');
    Force_10mm_23cm_Unkinked_Test9_Wrong = Data_10mm_23cm_Unkinked_Test9(:,1);
    Force_10mm_23cm_Unkinked_Test9_A0=((Force_10mm_23cm_Unkinked_Test9_Wrong/4.45) +30.882)/1.6475; %convert back to Arduino Output
    Force_10mm_23cm_Unkinked_Test9 = (((Force_10mm_23cm_Unkinked_Test9_A0)*0.1535)-1.963)*4.45; %corrected Force output (N)
    
    Pressure_10mm_23cm_Unkinked_Test9 =Data_10mm_23cm_Unkinked_Test9(:,2);
    Time_10mm_23cm_Unkinked_Test9 = Data_10mm_23cm_Unkinked_Test9(:,3);
    
    figure
    sgtitle('10mm 23cm BPA')
    subplot 311
    title('10mm 13cm BPA Static Pressure and Force')
    yyaxis left
    plot(Time_10mm_23cm_Unkinked_Test9,Force_10mm_23cm_Unkinked_Test9)
    ylim([-10,600])
    ylabel('Force(N)')
    hold on
    yyaxis right
    plot(Time_10mm_23cm_Unkinked_Test9,Pressure_10mm_23cm_Unkinked_Test9)
    ylim([-50,700])
    ylabel('Pressure(kPa)')
    legend('Force','Pressure')
    title('Unkinked Force and Pressure vs Time')
    hold off    
% plot
X = Pressure_10mm_13cm_Unkinked_Test9;
Y = Force_10mm_13cm_Unkinked_Test9;
X = [X Pressure_10mm_23cm_Unkinked_Test9];
Y = [Y Force_10mm_23cm_Unkinked_Test9];
figure 
plot(X,Y,'ro')
hold on
h = plot(X,Y,'b')
hold off
xlabel('Pressure (kPa)')
ylabel('Force (N)')
grid on

%%  Dr. Hunt's model
%optimization parameters

a0 = 254.3;%*10^3;
a1 = 192;%*10^3;
a2 = 2.0265;
a3 = -0.461;
a4 = -0.331;
a5 = 1.23;
a6 = 15.6;

%10mm BPA strain - length (29.8cm)
rest_length = 28.1;
max_contraction_length = 23.6;
kmax =(rest_length - max_contraction_length)./rest_length;
k = 1;
S=0;
F = linspace(0,600);
%Model
P = a0+(a1.*tand(a2.*(k./(a4.*F.*kmax))+a3)) + a5.*F+a6*S;

figure
plot(P,F)
figure
plot(F,P)

%% Optimization
%https://www.mathworks.com/help/optim/ug/nonlinear-data-fitting-problem-based-example.html
plot(X,Y,'ro')
title('Data points')

% try fitting data to nonlinear data function y = c(1)*exp(-lam(1)*t) + c(2)*exp(-lam(2)*t)

% define optimization variables of EQ above
c = optimvar('c',2);
lam = optimvar('lam',2);

%Set arbitrarily initial point x0
xo.c= [1,1];
xo.lam = [1,0];

%Function to compute response at pressure x when parameters = c & lam
%diffun = c(1)*exp(-lam(1)*X) + c(2)*exp(-lam(2)*X); %model equation to be decided. 
diffun = c(1)*X+c(2)+lambda;
%Convert diffun to optimization expression that sums the squares of
%difference between function and data Y (force)
diffexpr = sum((diffun-Y).^2);

%Create optimization problem having diffexpr as objective function
ssqprob = optimproblem('Objective',diffexpr);

%Solving using default solver
[sol,fval,exitflag,output] = solve(ssqprob,xo)

%Plot resulting curve based on returned values: sol.c sol.lam
resp = evaluate(diffun,sol);
hold on 
plot(X,resp)
hold off

%% Solution approach using fminunc (gradient based method) 
[xunc,fvalunc,exitflagunc,outputunc] = solve(ssqprob,xo,'solver',"fminunc");
resp2 = evaluate(diffun,xunc);
plot(X,Y,'ro')
title('optimize with fminunc')
hold on
plot(X,resp2)
hold off


fprintf(['There were %d iterations using fminunc,'...
    ' and %d using lsqvurvefit.\n'],...
    outputunc.funcCount,output.funcCount)


%% Nelder mead using (fminseach)

%optimize_mod = @(a1,a2,a3,a4,a5,a6)a0+(a1.*tand(a2.*(k./(a4.*F.*kmax))+a3)) + a5.*F+a6*S; %DrHunt'sModel
[x,fval,exitflag,output] = fminsearch(optimize_mod,a1,a2,a3,a4,a5,a6)


    