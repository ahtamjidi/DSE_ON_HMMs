function [A,x0,B,C] = create_sys_atmosphere_gold()
%Source and receptors are not on the boundaries (except z = 0)
%10^5 system, Full State Measurements
global opt_dist
%%
%SET PARAMETERS : Parameters can be changed
%Computational domain
xlim                            =   [ 0, 2000];  %[600m - 3000m]
ylim                            =   [-100, 400];
zlim                            =   [0, 50];
%Wind Profile parameters
Uwind                           =   4;    % wind speed (m/s) between 1-5 (m/s)
alp                             =   0/180 * pi;
beta                            =   0/180 * pi;
%Diffusion parameters
ay                              =   0.08*0.1;
by                              =   0.0001*0.1;
az                              =   0.06*0.1;
bz                              =   0.0015*0.1;
%discretization dimension
nx                              =   10;
ny                              =   10;
nz                              =   10;
dt                              =   1;




%%
%U = (U cos(alp)cos(beta), U cos(alpha) sin(beta), U sin(alp));
Ux = Uwind * cos(alp)*cos(beta);
Uy = Uwind * cos(alp)*sin(beta);
Uz = Uwind * sin(alp);
%Finite difference Scheme parameters
dx =( xlim(2) - xlim(1))/nx;
dy = (ylim(2) - ylim(1))/ny;
dz = (zlim(2) - zlim(1))/nz;
x0 = xlim(1) + [0 : nx]*dx;           % distance along wind direction (m)
y0 = ylim(1) + [0 : ny]*dy;           % cross-wind distance (m)
z0 = zlim(1) + [0 : nz]*dz;
[xmesh, ymesh] = meshgrid(x0,y0);
Ky = zeros(nx+1,1);
Kz = zeros(nx+1, 1);
for i = 1 : nx+1
    Ky(i,1) = Uwind * ay^2/2 * (2 * x0(i) + by *(x0(i))^2)/(1+by*x0(i))^2;
    Kz(i,1) = Uwind * az^2/2 * (2 * x0(i) + bz *(x0(i))^2)/(1+bz*x0(i))^2;
end

sy = Ky * dt/(dy^2);
sz = Kz * dt/(dz^2);
cx = Ux * dt/dx;
cy = Uy * dt/(dy);
cz = Uz * dt/(dz);
%Stable
% if 1 - 2 * max(sy+sz)-cx^2 -cx -cy-cz < 0
%     disp('Error: unstable system');
%     break;
% else
NUM_SYS = (ny-1)*(nx-1)*(nz);
%Primal system
[SR, S, SC] = atmo3dlax2 (Uwind, alp, beta, nx, ny, nz, xlim, ylim, zlim, Ky, Kz, dt);
%Adjoint system : Sad = S;
SRad = SC;
SCad = SR;
%%
%Source and receptor locations and discretization
% Stack emission source data:
source.n = 10;                         % # of sources
source.x = [280, 300, 900, 1100, 500,1300,500,1700,1400,700];     % x-location (m)
source.y = [ 75, 205, 25,  185,  250,230, 330,170, 240, 200];     % y-location (m)

source.z = [ 15,  35,  15,   15, 10, 10, 10, 10, 15, 20];     % height (m)
%source.label=[' S1'; ' S2'; ' S3'; ' S4'; 'S5';'S6';'S7';'S8';'S9';'S10'];
%source.n = 1;
%source.x = 1.1;
%source.y = 0;
%source.z = 0;

tpy2kgps = 1.0 / 31536;               % conversion factor (tonne/yr to kg/s)
source.Q = 1.5*[35, 80, 100, 50, 80, 50, 85, 100, 5, 110] * tpy2kgps ; % emission rate (kg/s)
%source.Q = 1;
% Stack discrete source data: Transfer from continuous to discrete
dissource.n = source.n;
dissource.x = floor((source.x - xlim(1))/dx)+1;
dissource.y = floor((source.y - ylim(1))/dy)+1;
dissource.z = floor((source.z - zlim(1))/dz)+1;
%%
%USE IF NUM_SYS IS SMALL.
A = sparse(NUM_SYS, NUM_SYS);
for i = 1 : length(S)
    A(SR(i), SC(i)) = S(i);
end
%Receptors
recept.n = 9;                                                 % # of receptors
recept.x = [  60,  76, 267, 331, 514, 904, 1288, 1254, 972 ]; % x location (m)
recept.y = [ 130,  70, -21, 308, 182,  75,  116,  383, 507 ]; % y location (m)
recept.z = [   0,  10,  10,   1,  15,   2,    3,   12,  12 ]; % height (m)
recept.label=[ ' R1 '; ' R2 '; ' R3 '; ' R4 '; ' R5 '; ' R6 '; ...
    ' R7 '; ' R8 '; ' R9 ' ];
disrecept.n = recept.n;
disrecept.x = floor((recept.x - xlim(1))/dx)+1;
disrecept.y = floor((recept.y - ylim(1))/dy)+1;
disrecept.z = floor((recept.z - zlim(1))/dz)+1;


NUM_OUT                 = recept.n;
NUM_IN                  = source.n;

B = sparse(NUM_SYS, source.n);
for ns = 1 : source.n
    B((nx-1)*(ny-1)*(dissource.z(1,ns)-1)+(nx-1)*(dissource.y(1,ns)-2)+dissource.x(1,ns)-1, ns) = 1;
end
Ft = (1 - (source.x - x0(dissource.x))/dx).*(1 -(source.y - y0(dissource.y))/dy) .* (1- (source.z - z0(dissource.z))/dz) .* source.Q *dt/(dx*dy*dz);
C = sparse(recept.n, NUM_SYS);
for ns = 1 : recept.n
    C(ns,(nx-1)*(ny-1) * (disrecept.z(1,ns)-1) + (nx-1) * (disrecept.y(1,ns) -2) + disrecept.x(1,ns)-1) = 1;
end

x0 =zeros(size(A,1),1);
% % figure
for i=1:700
    x0 =A*x0 + B*source.Q';
    Cd = addboundary(x0, nx, ny, nz);
    %     contourf(xmesh,ymesh,Cd(:,:,2))
%     imagesc(Cd(:,:,2))
    
    %     pause(0.01)
end
% end
% is_stable = 0;
% while ~is_stable
%     sys = drss(40,9,10);
%     is_stable = isstable(sys);
% end
% rank(obsv(sys.A,sys.C));
% rank(ctrb(sys.A,sys.B));
%  [hsv,BALDATA] = hsvd(sys);
 
%  ORDERS = numel(find(hsv>0.01*max(hsv(:))));

% rsys = balred(sys,ORDERS,BALDATA);

% A = full(rsys.A);
% B = full(rsys.B);
% C = full(rsys.C);
% opt_dist.sys = sys;
% opt_dist.rsys = rsys;
% opt_dist.order = ORDERS;
% opt_dist.A = full(rsys.A);
% opt_dist.B = full(rsys.B);
% opt_dist.C = full(rsys.C);


% % reduced order model from dan
load RPODmodel_t
idx_c = [24934       24935       26102       26458       28042       31824       32783       35002       36106];
opt_dist.A =At;
opt_dist.B = Bt;
opt_dist.C = Ct(idx_c',:);
A=At;B=Bt;C= Ct(idx_c',:);
source.n = 10;                         % # of sources
source.x = [280, 300, 900, 1100, 500,1300,500,1700,1400,700];     % x-location (m)
source.y = [ 75, 205, 25,  185,  250,230, 330,170, 240, 200];     % y-location (m)
source.z = [ 15,  35,  15,   15, 10, 10, 10, 10, 15, 20];     % height (m)

source.label=[' S1'; ' S2'; ' S3'; ' S4'; ' S5';' S6';' S7';' S8';' S9';'S10'];

x0 =zeros(size(A,1),1);
% figure

% % model generated inside code
opt_dist.A = full(A);
opt_dist.B = full(B);
opt_dist.C = full(C);
% rank(obsv(A,C))
% rank(ctrb(A,B))


opt_dist.recept = recept;
opt_dist.source = source;

for i=1:10
    x0 =A*x0 + B*source.Q';
%     Cd = addboundary(x0, nx, ny, nz);
    %     contourf(xmesh,ymesh,Cd(:,:,2))
%     imagesc(Cd(:,:,2))
    
    %     pause(0.01)
end




% sys1.A = A 
% sys1.B = B
% sys1.C = C
% sys1 = ss(full(A),full(B),full(C),[]);
% [hsv,BALDATA] = hsvd(sys1);
%  
%  ORDERS = numel(find(hsv>0.01*max(hsv(:))));
% 
% rsys = balred(sys1,ORDERS,BALDATA);
% A = full(rsys.A);
% B = full(rsys.B);
% C = full(rsys.C);
% opt_dist.sys = sys1;
% opt_dist.rsys = rsys;
% opt_dist.order = ORDERS;
% opt_dist.A = full(rsys.A);
% opt_dist.B = full(rsys.B);
% opt_dist.C = full(rsys.C);