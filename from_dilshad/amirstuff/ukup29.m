function [hX,wm,Xb,Pb]=ukup29(X,P,W,R,t,yz)

% this code takes a GMM of the predicted prior PDF and performs mixture UKF
% update on them



%R= measurement noise covariance
%t=time
%yz=measurement



l=length(W); %number of mixture components fit

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

hX=Xb*wm';                                        %posterior mean.