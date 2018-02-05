X = 0:0.01:1;
P1 = normpdf(X,0.5,.3/3);
P1 = P1./sum(P1);
P2 = normpdf(X,0.35,.5/3);
P2 = P2./sum(P2);
P3 = normpdf(X,0.75,.5/3);
P3 = P3./sum(P3);

P_opt = P1.*P2.*P3;
P_opt = P_opt./sum(P_opt);

%%
omegaVec = 0:0.01:1;
Pa = P1.*P2;
Pa = Pa./sum(Pa);
Pb = P1.*P3;
Pb = Pb./sum(Pb);

for i=1:length(omegaVec)
     P_fus(i,:) = DiscFusion(Pa,Pb,omegaVec(i));
     H(i) = calcEnthrop(P_fus(i,:));
end

[m,n_omega] = max(H);


%%
close all;
hold on
plot(X,P1,'--');
plot(X,P2,'--');
plot(X,P3,'--');
plot(X,P_opt,'linewidth',2);
plot(X,Pa,'.-');
plot(X,Pb,'.-');
plot(X,P_fus(n_omega,:),'linewidth',2);
legend('P1','P2','P3','P1*P2*P3','Pa','Pb','P_fus');

figure;
plot(omegaVec,H)