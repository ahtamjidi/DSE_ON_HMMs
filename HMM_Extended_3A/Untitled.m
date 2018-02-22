a(:,1) = PM_GCF_CEN.meanTVD;
a(:,2) = PM_GMD_CEN.meanTVD;
a(:,3) =[0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0]';
a(:,4) = (PM_GCF_CEN.meanTVD >=  PM_GMD_CEN.meanTVD)';