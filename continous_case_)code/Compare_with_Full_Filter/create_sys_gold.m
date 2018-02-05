function [A,x0,B,C] = create_sys_gold()
%Source and receptors are not on the boundaries (except z = 0)
%10^5 system, Full State Measurements
global opt_dist
source.Q = [1 1];
%%
A = [1 0;0 1];
%Receptors

B = [1 0;0 1];
C = [repmat(eye(2),4,1);[1 0]];
% C = zeros(9,2);
x0 =zeros(size(A,1),1);
opt_dist.order = 2;
opt_dist.A = A;
opt_dist.B = B;
opt_dist.C = C;
opt_dist.source = source;



