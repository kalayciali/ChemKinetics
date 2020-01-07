%% Ali KALAYCI
%% CHE302 Chemical Kinetics and Reactor Design Project

%% Problem file is in directory
%% PFR with heat exchanger,  conversion vs. PFR volume
%% Calculations are made for one pipe out of 1000 pipes

%% Clean the stage
clear;
clc;
close all;

global npA0t npK0t npM0t D P T0 R dH0 Xa Ya Za Xk Yk Zk Xm Ym Zm U Tamb

Tamb= 1150;    % ambient temperature, K
U= 110;     % overall heat transfer coeff, J/(m^3.s.K)
D=0.0266;     % diameter of one tube, m
Xa= 26.63 ;  % acetone A value, J/(mol*K)
Xk= 20.04;   % ketone A value, J/(mol*K)
Xm= 13.39 ;   % methane A value, J/(mol*K)
Ya= 0.183 ;  % acetone A value, J/(mol*K^2)
Yk= 0.0945;   % ketone B value, J/(mol*K^2)
Ym= 0.077 ;   % methane C value, J/(mol*K^2)
Za= -45.86* 10^-6 ;  % acetone A value, J/(mol*K^3)
Zk= -30.95* 10^-6;   % ketone B value, J/(mol*K^3)
Zm= -18.71* 10^-6;   % methane C value, J/(mol*K^3)
dH0= 80000.77;     % Hrxn at 25 C, J/mol 
npA0t= 38.3/ 1000;           % inlet molar flowrate per tube, mol/s
P      = 162000 ;         % Inlet pressure, Pa
T0     = 1035;        % Inlet temperature, K
R      = 8.314;   % Universal gas constant, m^3*Pa/(mol*K)
npK0t = 0;            % Inlet molar flowrate of B, mol/s
npM0t = 0;            % Inlet molar flowrate of C, mol/s


% Volume span and initial conditions 
Vspan = linspace(0,0.001,1000);   % Volume span for calculation, m^3
xi    = [0 T0];  % Extent of reaction and temperature at the inlet

%% Solution of ODEs
% x(1)=eps, x(2)=T
[V,x]=ode45(@funpfr_hexc, Vspan, xi);

%% Extracting and plotting the results

% Calculation of molar flowrates
ndA = npA0t - x(:,1);  % Molar flowrate of A
ndK = npK0t + x(:,1);  % Molar flowrate of K
ndM = npM0t + x(:,1);  % Molar flowrate of M

% conversion
conv= (npA0t- ndA)/ npA0t
% Plot of molar flowrates vs. volume
figure(1)
plot(V,ndA,'r',V,ndK,'b',V,ndM,'k','linewidth',2);
title('Molar flowrate vs. volume');
xlabel('Volume, L');
ylabel('Molar flowrate, mol/s');
legend('ndot_A','ndot_B','ndot_C');

% plot of conversion vs. volume
figure(2)
plot(V, conv,'linewidth',2);
title('conversion vs. volume');
xlabel('Volume, L');
ylabel ('conversion');

% Plot of temperature vs. volume
figure(3)
plot(V,x(:,2),'linewidth',2);
title('Temperature vs. volume');
xlabel('Volume, L');
ylabel ('Temperature, K');
