%% build current local grid map from laser data
%
% inputs: 
% - Lx, Ly: laser end points [x & y]
% - trsh:   treshold to remove outlier (laser endpoints that are outside the reliable range of laser)           
% - gs:     grid size (in each dim.)
% - sz:     size of each cell (in meters)
%
% output: 
% - mp:     calculated map
%
% P.S. for bresenham algorithm a version written by "N. Chattrapiban" is
% used with slight modification
%
% Alireza Asvadi, Aug. 12 2014

function map = mp(i, Lx, Ly, trsh, gs, sz) 

%% eliminate unrelevant values 
las   = [Lx(i,:); Ly(i,:)];                                % laser end point [robot centric]
dist  = sqrt((las(1,:).^2)+(las(2,:).^2));                 % end point distance from laser
ind   = repmat((dist < trsh),2,1) > 0.5;                   % eliminate unrelevant values (indexes of the true laser points)
las   = reshape(las(ind),2,sum(ind(:))/2);                 % laser data within the range
%% quantize
qls   = floor(las/gs);                                     % quantized laser end point
%% laser end points inside local grid
gsz   = sz / 2;                                            % half size of x
indi  = repmat((qls(1,:) <= gsz).*(qls(1,:) > -gsz).*(qls(2,:) <= gsz).*(qls(2,:) > -gsz),2,1) > 0.5; % indexes for laser points inside local grid
qli   = reshape(qls(indi),2,sum(indi(:))/2);               % laser data within the range
%% interpolate laser end points that are out of the local grid
indo  = ~indi;                                             % indexes for laser points outside local grid
qlo  = reshape(qls(indo),2,sum(indo(:))/2);                % laser data within the range

for i = 1:size(qlo,2)                                      % interpolate for every point outside of the local grid
A     = [0;qlo(1,i)]; B = [0;qlo(2,i)];                    % origin & end points
if abs(qlo(1,i)) >= abs(qlo(2,i))                          % if (x > y) search for y correspond with (x = gsz)
    if abs(qlo(1,i)) >= 0; x = gsz; else x = -gsz+1; end   % see if it is x = 100 or x = -100 (alter to agree with -99 ~ 100)
    y = fix(interp1(A,B,x));                               % find border y
    if y == -gsz; y = -gsz+1; end
else                                                       % if (y > x) search for x correspond with (y = gsz)
    if abs(qlo(2,i)) >= 0; y = gsz; else y = -gsz+1; end   % see if it is y = 100 or y = -100 (alter to agree with -99 ~ 100)
    x = fix(interp1(B,A,y));                               % find border x 
    if x == -gsz; x = -gsz+1; end
end
qlo(1,i) = x; qlo(2,i) = y;                                % rewrite qlso
end

map       = zeros(sz, sz) + 0.5;                           % gridmap
%% transform from world coordinate to image coordinate
qlip      = zeros(size(qli));                              % initialize
qlop      = zeros(size(qlo));
qlip(1,:) = qli(1,:) + (sz/2);                             % xp = x + (sz/2);   (x:[-99 ~ 100] ---> xp:[1 ~ 200])
qlop(1,:) = qlo(1,:) + (sz/2);
qlip(2,:) = -qli(2,:) + (sz/2) + 1;                        % yp = x + (sz/2+1); (y:[-99 ~ 100] ---> yp:[1 ~ 200])
qlop(2,:) = -qlo(2,:) + (sz/2) + 1;
%% end points are inside the grid: show free and occupied (hit point) cells
for i    = 1:size(qlip,2)                                  % show free space  
or       = [(sz/2), (sz/2)+1];
en       = qlip(:,i)';
map      = bresen(map,[or;en]);                            % origin and end points
map(en(2),en(1)) = 0;                                      % show hit points
end
%% end points are outside the grid: show free cells
for j    = 1:size(qlop,2)                                  % show free space
or       = [(sz/2), (sz/2)+1];
en       = qlop(:,j)';
map      = bresen(map,[or;en]);                            % origin and end points
end

%% Bresenham
function outmat = bresen(mat, input)

outmat = mat;
x      = round(input(:,1));
y      = round(input(:,2));
%% re-order steep
steep  = (abs(y(2)-y(1)) > abs(x(2)-x(1)));
if steep, [x,y] = swap(x,y);  end
if x(1) > x(2), 
    [x(1),x(2)] = swap(x(1),x(2));
    [y(1),y(2)] = swap(y(1),y(2));
end
%% set step +1 or -1
delx   = x(2)-x(1);
dely   = abs(y(2)-y(1));
error  = 0;
x_n    = x(1);
y_n    = y(1);
if y(1) < y(2), ystep = 1; else ystep = -1; end
%% fill matrix
for n  = 1:delx+1
    if steep,
        outmat(x_n,y_n) = 1;
    else
        outmat(y_n,x_n) = 1;
    end    
    x_n   = x_n + 1;
    error = error + dely;
    if bitshift(error,1,'int64') >= delx, % same as -> if 2*error >= delx, 
        y_n   = y_n + ystep;
        error = error - delx;
    end    
end

%% function swap
function [q,r] = swap(s,t)       
q = t; r = s;
