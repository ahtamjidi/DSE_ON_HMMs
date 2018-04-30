%% Cleanup
clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Configuration
Sim = Config351();
%% Simulation
iPass = 1;
dStep = .01;
for beta = 0:dStep:1
    Sim.RG_beta = beta;
    [PM(iPass),Sim,HMM,Network] = SIM(Sim,0);
    disp(char(strcat('Pass',{' '},num2str(iPass),' is done')));
    iPass=iPass+1;
end
%% Plots
HYB2CEN = zeros(1/dStep+1,1); ICF2CEN = HYB2CEN; FHS2CEN = HYB2CEN;
for iPass =1:length(PM)
    HYB2CEN(iPass) = 1-mean(PM(iPass).HYB2CEN.meanL1)/2;
    ICF2CEN(iPass) = 1-mean(PM(iPass).ICF2CEN.meanL1)/2;
    FHS2CEN(iPass) = 1-mean(PM(iPass).FHS2CEN.meanL1)/2;
end
HYB2CEN_M = zeros(1/dStep+1,1); ICF2CEN_M = HYB2CEN; FHS2CEN_M = HYB2CEN;
for iPass =1:length(PM)
    HYB2CEN_M(iPass) = 1-mean(max(PM(iPass).HYB2CEN.L1))/2;
    ICF2CEN_M(iPass) = 1-mean(max(PM(iPass).ICF2CEN.L1))/2;
    FHS2CEN_M(iPass) = 1-mean(max(PM(iPass).FHS2CEN.L1))/2;
end
HYB2CEN_MM = zeros(1/dStep+1,1); ICF2CEN_MM = HYB2CEN; FHS2CEN_MM = HYB2CEN;
for iPass =1:length(PM)
    HYB2CEN_MM(iPass) = 1-max(max(PM(iPass).HYB2CEN.L1))/2;
    ICF2CEN_MM(iPass) = 1-max(max(PM(iPass).ICF2CEN.L1))/2;
    FHS2CEN_MM(iPass) = 1-max(max(PM(iPass).FHS2CEN.L1))/2;
end
yellow = [255,165,0]/255;
hold on
axis equal;
axis([0 1 0 1])
m = min(HYB2CEN);
plot(0:dStep:1,(FHS2CEN-m )/(1-m),'-s','color',yellow);
plot(0:dStep:1,(HYB2CEN-m )/(1-m),'-.s','color','blue');
plot(0:dStep:1,(ICF2CEN-m )/(1-m),'-.s','color','red');
xlabel('Probability of Link Failure');
ylabel('Realtive Performance');
legend('FHS','HYB','ICF')

figure;
hold on 
plot(0:dStep:1,FHS2CEN_M,'-*','color',yellow);
plot(0:dStep:1,HYB2CEN_M,'-*','color','blue');
plot(0:dStep:1,ICF2CEN_M,'-*','color','red');

figure;
hold on 
plot(0:dStep:1,FHS2CEN_MM,'-*','color',yellow);
plot(0:dStep:1,HYB2CEN_MM,'-*','color','blue');
plot(0:dStep:1,ICF2CEN_MM,'-*','color','red');