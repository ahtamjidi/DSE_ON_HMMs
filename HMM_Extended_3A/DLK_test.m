clear all
% close all
% clc
a=0.8649;
b=0.7175;
Network.NumNodes = 2;

X = 0:0.01:1;
P1 = normpdf(X,0.5,.3/3);
P1 = P1./sum(P1);
P2 = normpdf(X,0.35,.5/3);
P2 = P2./sum(P2);
P3 = normpdf(X,0.75,.5/3);
P3 = P3./sum(P3);
Pa = P1.*P2;
Pa = Pa./sum(Pa);
Pb = P1.*P3;
Pb = Pb./sum(Pb);

Network.Node(1).Prior(:,1) = P1;%[0.2;0.3;0.5]; 
Network.Node(2).Prior(:,1) = P2;%[0.1;0.7;0.2];
om = 0:0.001:1;
for i = 1: size(om,2)
    KLD_error(i) = KLDCostFuncGMD([om(i) 1-om(i)],Network,1);
    KLD_error2(i) = KLDCostFuncGMD2([om(i) 1-om(i)],Network,1);
    KLD_error3(i) = KLDCostFuncGMD3([om(i) 1-om(i)],Network,1);
    
    omega = [om(i) 1-om(i)];
    Prior = ones(size(Network.Node(1).Prior(:,1)));
    for j = 1:Network.NumNodes
        Prior = Prior.*Network.Node(j).Prior(:,1).^omega(j);
    end
    Prior = Prior/sum(Prior);
    ent(i) = Entropy(Prior);
end

figure
plot(om,KLD_error,'-*');
hold on
plot(om,KLD_error2,'-*');
plot(om,KLD_error3,'-*');
plot(om,ent,'-*');
grid minor;