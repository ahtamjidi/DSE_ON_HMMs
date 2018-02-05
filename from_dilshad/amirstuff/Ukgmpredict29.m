function [Xins,Pints]=Ukgmpredict29(Xs,Ps,Q,dt)
%mixture UKF predictor for the gmm given by means Xs, cov Ps. Notice that
%since the number of components remain fixed during mixture UKF prediction
%there is no splitting etc. Also weights of the GMM components remain fixed

%This function calls another function dyn which is the process model.
%Replace with ur own process model.


%Q is process covariance



%dt is step size

for tuy=1:size(Xs,2)      
    X=Xs(:,tuy);                     %accessing each component of the GMM
    P=Ps(:,:,tuy);
alpha=1.3;
beta=1.5;                  %feel free to choose alpha,beta and k that suits ur application
k=0.2;
L=length(X);
lam=(((alpha^2)*(L+k))-L);
gam=sqrt(L+lam);
wmf=lam/(L+lam);
wcf=wmf+1+beta-(alpha^2);
wmn=1/(2*(L+lam));
wcn=1/(2*(L+lam));
wm=zeros((2*L)+1,1);
wc=zeros((2*L)+1,1);
wm(1)=wmf;
wc(1)=wcf;
for i=1:2*L
    wm(i+1)=wmn;
    wc(i+1)=wcn;
end
uX=zeros(L,(2*L)+1);
eS=chol(P)';                                 % Lower triangular part of cholesky factor
uX(:,1)=X;                                   % Here we calculate the sigma points. ux(:,1) is the first sigma point. Others are followed
for i=1:L
       uX(:,i+1)=X+(gam*eS(:,i));
end
for i=1:L
        uX(:,i+L+1)=X-(gam*eS(:,i));
end
        
for i=1:(2*L)+1
        uX(:,i)=dyn(uX(:,i),k,Q,dt,0);         %process model
end
        
    Xin=0;                       
    for i=1:(2*L)+1
        Xin=Xin+wm(i)*uX(:,i);      % Mean of the propagated points. 
    end

    Pint=0;
    for i=1:(2*L)+1
        Pint=Pint+(wc(i)*(uX(:,i)-Xin)*(uX(:,i)-Xin)');     % Covariance of the propagated points based on the mean caluclated before
    end
    Pint=Pint+Q;                                            %process noise is added to covariance. 
    
    Xins(:,tuy)=Xin;
    Pints(:,:,tuy)=Pint;         %propagated means and covs
end
    