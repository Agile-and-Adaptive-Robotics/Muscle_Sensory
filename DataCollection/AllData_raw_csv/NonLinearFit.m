% regression to optimize equation

%k = readmatrix('OptimizingParameters.xlsx','Sheet','Model7_2')
diameter=10; lengths=30; test=10;
[diameter,lengths,lo,li,l620,kink,kmax,testnum,State,B0,B1] = choosedata(diameter,lengths,test);
strain = (lo - li)./lo;
max_strain = (lo - l620)./ lo;
relative_strain = strain./max_strain;

%%  creating nonlinear fit matrix
for i = 1:2 %cycles P and DP. 
    X = [strain'];
    y = B1(i,:)';
    
    modelfun = @(b,x)b(1)+b(2)*x(:,1).^2;
    beta0 = [5 5];
    md1 = fitnlm(X,y,modelfun,beta0)
    a = md1.Coefficients.Estimate
    xfit = linspace(0,1,100);
    yfit = a(1) + a(2).*(xfit).^2;
    
    figure(i)
    plot((strain),y,'o');
    hold on
    plot(xfit,yfit);
    hold off
    xlabel('1-relative_strain')
    ylabel('B1')
    
end