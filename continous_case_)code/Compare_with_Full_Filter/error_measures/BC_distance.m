function dist = BC_distance(mu1,cov1,mu2,cov2)
cov = 0.5*(cov1+cov2);
% mu1 = mu2;
dist = (1/8)*(mu1-mu2)'*pinv(cov)*(mu1-mu2) + 0.5*(log(det(cov))-0.5*log((det(cov1))) -0.5*log((det(cov2))));%0.5*log(det(cov)/sqrt(det(cov1)*det(cov2)));
dist = exp(-dist);
end