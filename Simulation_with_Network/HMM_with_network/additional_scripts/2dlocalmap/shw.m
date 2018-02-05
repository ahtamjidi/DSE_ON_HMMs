%% show grid map, laser points, robot locations, and current robot direction
%
% inputs:
% - lmap:   current local map
% - Lx, Ly: laser end points [x & y]
% - X:      estimated odometry data
% - pts:    all end points till now (for plot)
% - i:      measurement number
% - st:     the step between measurement no. (for debug)
% - nm:     last measurement no.
% - rbr:    robot radius (in meter)
% - gs:     grid size (in each dim.)
% - sz:     size of each cell (in meter)
%
% output:
% - pts:    all saved end points till now
%
% Alireza Asvadi, Aug. 12 2014 

function pts = shw(lmap, Lx, Ly, X, pts, i, st, nm, rbr, gs, sz)

%% write robot size on the laser map
rbg = ceil(rbr/gs);                                                % robot grid radious
lmap(sz/2:sz/2+2,sz/2:sz/2) = 0;                                   % just for show the direction (the center of this part is robot center)
lmap(sz/2-rbg+1:sz/2+rbg+1,sz/2-2*rbg-1:sz/2-1) = 0;               % grided robot location
%% show current grided laser measurement
subplot(1,2,1);
imshow(lmap)                                                       % current grided laser measurement
odom(1,1:2)  = round(X(i+st,1:2)/gs);
odom(1,3)    = round(X(i+st,3) *(180/3.14));
title(['odom: ', '  x: ',num2str(odom(1)), '  y: ',num2str(odom(2)), '  theta: ',num2str(odom(3))])
%% coordinate correction, considering robot direction & location             
pt_rc    = [Lx(i+st,:); Ly(i+st,:)];                               % laser end point (robot centric)
rotn     = [cos(X(i+st,3)), -sin(X(i+st,3)); sin(X(i+st,3)), cos(X(i+st,3))];  % robot direction (teta) 
pt_wc    = rotn*pt_rc + repmat([X(i+st,1);X(i+st,2)], 1, 180);     % robot location (x & y)
%% save previous points to plot all
pts(1,1+180*(i-1):180+180*(i-1)) = pt_wc(1,:);                     % prepare for "plot all"
pts(2,1+180*(i-1):180+180*(i-1)) = pt_wc(2,:);
%% show all laser points and robot locations till now, and current robot direction
subplot(1,2,2);
plot(pts(1,1:180*i), pts(2,1:180*i), 'k.', 'MarkerSize', 2);                        % Robot laser end (all the previous measurements)
hold on
quiver(X(i+st,1), X(i+st,2), cos(X(i+st,3)), sin(X(i+st,3)), 'k'); % Robot Pose
plot(X(1:i+st,1), X(1:i+st,2), 'Marker', 'o', 'MarkerSize', 5);    % Robot location
plot(pt_wc(1,:), pt_wc(2,:), 'r.');                                % Robot laser end (new measurement)
rd       = (sz*gs)/2;                                              % local map (half of side)
c_pt     = [rd, -rd, -rd, rd; rd, rd, -rd, -rd];                   % region (corner points)
c_pt_wc  = rotn*c_pt + repmat([X(i+st,1);X(i+st,2)], 1, 4);        % corner points in world coordinate
plot([c_pt_wc(1,:),c_pt_wc(1,1)],[c_pt_wc(2,:), c_pt_wc(2,1)],'g','LineWidth',3)
hold off
title(['measurement no. ', num2str(i+st), '/',num2str(nm)])        % number of measurement
axis([-10 30 -20 20])
axis square
grid on
pause(0.01)

end

