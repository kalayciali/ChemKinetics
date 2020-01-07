function dxdv=funadpfr(V,x)

%% Identification of global variables
global npA0t npK0t npM0t D P T0 R dH0 Xa Ya Za Xk Yk Zk Xm Ym Zm U Tamb

%% Decleration of ODEs
% x(1)=eps, x(2)=T
a= 4/D;    % lateral area per volume, 1/m
k = exp(34.34- 34222/x(2));
%k= 3.58* exp(34222* (1/1035- 1/x(2)))
firstt= (npA0t- x(1))*(Xa+ Ya*x(2)+ Za*x(2)^2) + x(1)*(Xk+ Yk*x(2)+ Zk*x(2)^2) + x(1)*(Xm+ Ym*x(2)+ Zm*x(2)^2);
dX= Xm+ Xk- Xa;   % deltaA
dY= Ym+ Yk- Ya;    %deltaB
dZ= Zm+ Zk- Za;   %deltaC
Hrxn= dH0+ (dX*(x(2)- 298)+ dY/2*(x(2)^2- 298^2)+ dZ/3*(x(2)^3- 298^3));

dxdv = [k* (npA0t-x(1))*P / ((npA0t+x(1))* R* x(2));
    (-k* (npA0t- x(1))/(((npA0t+x(1))* R* x(2))/P)*Hrxn/firstt)+ (U*a*(Tamb- x(2)))/firstt];
end
