size1 = 1;
size2 = 30;
source1 = rand(size1,size2);
source1 = source1./sum(source1);
source2 = rand(size1,size2);
source2 = source2./sum(source2);


omegaVec = 0:0.01:1;

for i=1:length(omegaVec)
     pF(i,:) = DiscFusion(source1,source2,omegaVec(i));
     H(i) = calcEnthrop(pF(i,:));
end

[m,n_omega] = max(H);
close all;
plot(pF(n_omega,:));
hold on
plot(source1);
plot(source2);
legend('Fuse','s1','s2');

figure;
plot(omegaVec,H)