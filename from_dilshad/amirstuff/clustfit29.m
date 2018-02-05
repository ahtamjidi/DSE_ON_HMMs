function [wp,mup,covp,idk1]=clustfit29(part,Nmax)

%code for clustering using kmeans. Given the particles and an upperbound
%Nmax, this code chooses an N in [1,Nmax] which maximizes the likelihood agreement
%measure

n=size(part,2);
Lp=0;
for l=Nmax:-1:1
    [idk]=kmeans(part',l,'MaxIter',200);
    clear w;
    clear mu;
    clear covarr;
    clear pval;
    for i=1:l
        cst=part(:,idk==i);
        w(i)=size(cst,2)/n;
       % w(i)=1/l
     mu(:,i)=mean(cst,2);
    
      tryli=size(timvarc(cst));
        covarr(:,:,i)=timvarc(cst); 
        [rrot,pval(i)]=chol(covarr(:,:,i));
    end
  
    if min(w)>=(2/n)&&max(abs(pval))==0
      

        Lc=0;
        for ni=1:n
        for nc=1:l
        
            Lc=Lc+(w(nc)*mvnpdf(part(:,ni),mu(:,nc),covarr(:,:,nc)));
        end
        end
    else
        Lc=0;
        
    end
    
    if Lc>=Lp
            Lp=Lc;
            wp=w;
            mup=mu;
            covp=covarr;
            idk1=idk;
    end
end  
            
        