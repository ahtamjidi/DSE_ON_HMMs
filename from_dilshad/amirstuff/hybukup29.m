function [hpart,hX,W,wm, Xb,Pb]=hybukup29(hpart,Nmax,R,t,yz)

% this code takes propagated particles ,fits a gmm and performs UKF update
% on tehm


%hpart= propagated particles
%Nmax= maximum number of clusters
%R= measurement noise covariance
%t=time
%yz=measurement

[W,X,P,idk1]=clustfit29(hpart,Nmax);   %fitting GMM to the particles, W,X,P gives weights means and covs of GMM.

l=size(X,2);  %number of mixture components fit

for i=1:l
    Pbar=P(:,:,i);
    Xbar=X(:,i);
    [wsp(i),Xb(:,i),Pb(:,:,i)]=Ukupdatew29(Xbar,Pbar,yz,t,R); % compute updated weight, mean and cov using UKF
   
     wm(i)=W(i)*wsp(i);  %multiply weights (i.e prior weight times likelihood)

end


if l>1
wm=wm/sum(wm);      %normalize weights
else
    wm=1;
    
end
hpart=mixsamp(wm,Xb,Pb,size(hpart,2));           %sample new set of particles for next step
hX=Xb*wm';                                        %posterior mean.