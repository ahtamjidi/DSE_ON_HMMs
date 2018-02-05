function [wn,mun,covn]=mixmergenorm(w,mu,cov,tol)

%with the normalized merge criterion.

%the mixmerge fuction merges components of the Gaussian mixture model
%specified by the parameters w,mu and cov. 
% w= mixture weights ( 1 x m)
% mu = mixture means (n x m)
% cov = mixture covariances ( n x n x m)
% The components are merged based when the product integral I is greater
% than a set threashold. 
% I=int N(x,mu1,cov1) . N(x,mu2,cov2) dx  
% I may be evaluted as I= N(mu1,mu2,cov1+cov2). The components are merged
% when exp(-( (mu1-mu2)'/(cov1+cov2))9*(mu1-mu2)) is smaller than a set tolerance.

m=size(w,2);
n=size(mu,1);
con2=2^(-n/2);
len=m;
i=1;


ws=w;
mus=mu;
covs=cov;
while i<=len
    lvec=zeros(len,1);
    for j=1:len
        if j~=i
        s=((con2*((det(2*pi*covs(:,:,i)))^-0.5))+(con2*((det(2*pi*covs(:,:,j)))^-0.5))-likly(mus(:,i),mus(:,j),covs(:,:,i)+covs(:,:,j)))/((con2*((det(2*pi*covs(:,:,i)))^-0.5))+(con2*((det(2*pi*covs(:,:,j)))^-0.5))); 
          if s<tol
              lvec(j)=1;
          end
        else
            lvec(j)=1;
        end
    end
       
        if sum(lvec)>1
        wps=ws(lvec==1);
        mups=mus(:,lvec==1);
        covps=covs(:,:,lvec==1);
        wpsum=sum(wps);
        wps=wps/wpsum;
        mu1=(wps*mups')';
        cov1=0;
        for k=1:sum(lvec)
        cov1=cov1+(wps(k)*(covps(:,:,k)+((mups(:,k)-mu1)*(mups(:,k)-mu1)')));
        end
        in=1:len;
        len=len+1-sum(lvec);
        i=min(in(lvec==1));
      
       
       
        wl=[ws(:,1:i-1) wpsum ws(:,((in>i).* (lvec==0)')==1)];
        mul=[mus(:,1:i-1) mu1 mus(:,((in>i) .*( lvec==0)')==1)];
        covk(:,:,1:i-1)=covs(:,:,1:i-1);
        covk(:,:,i)=cov1;
        covk(:,:,i+1:len)=covs(:,:,((in>i).*(lvec==0)')==1);
        covl=covk(:,:,1:len);
        ws=wl;
        mus=mul;
        covs=covl;
        else
            i=i+1;
        end
end
        wn=ws;
        mun=mus;
        covn=covs;
        
       
        
        
      
            
       
  




