function dxdv=funadpfr(V,x)

%% Identification of global variables
global npA0 npK0 npM0 P T0 R dH0 Xa Ya Za Xk Yk Zk Xm Ym Zm

%% Decleration of ODEs
% x(1)=eps, x(2)=T
k = exp(34.34- 34222/x(2));
firstt= (npA0- x(1))*(Xa+ Ya*x(2)+ Za*x(2)^2) + x(1)*(Xk+ Yk*x(2)+ Zk*x(2)^2) + x(1)*(Xm+ Ym*x(2)+ Zm*x(2)^2);
dX= Xm+ Xk- Xa;   % deltaA
dY= Ym+ Yk- Ya;    %deltaB
dZ= Zm+ Zk- Za;   %deltaC
Hrxn= dH0+ (dX*(x(2)- 298)+ dY/2*(x(2)^2- 298^2)+ dZ/3*(x(2)^3- 298^3));
dxdv = [k* (npA0-x(1))*P / ((npA0+x(1))* R* x(2));
    -k* (npA0- x(1))/(((npA0+x(1))* R* x(2))/P)*Hrxn/firstt];
end
