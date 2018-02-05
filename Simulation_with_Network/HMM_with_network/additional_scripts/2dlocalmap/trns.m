%% transform map 1 on map 2
%
% inputs:
% - map:    current laser measurement map
% - X:      estimated odometry data
% - i1:     previous measurement number
% - i2:     current measurement number
% - gs:     grid size (in each dim.)
%
% output:
% - mapt:   transformed laser measurement map
%
% P.S. it uses " Piotr's Image&Video Toolbox Version 3.01" for
% transformation
%
% Alireza Asvadi, Aug. 21 2014 


function mapt = trns(map, X, i1, i2, gs)

%% pose difference
dtheta        = X(i1,3) - X(i2,3);                            % robot pose difference between i1 & i2)
%% convert delta x & delta y from world coordinate to robot coordinate
theta         = X(i2,3);                                      % robot pose at i2
x             = (X(i2,1) - X(i1,1)) / cos(theta);             % translation in robot coordinate
y             = (X(i2,1) - X(i1,1))*(-sin(theta)) + (X(i2,2) - X(i1,2))*(cos(theta));
trans         = [x, y]/gs;                                    % grided position difference
%% transformation
R     = [cos(dtheta) -sin(dtheta)                             % rotation (takes the center of the image as the origin)
         sin(dtheta) cos(dtheta)];
T     = [trans(2); -trans(1)];                                % translation (in row/column format [x; y] = [c; r])
H     = [R T; 0 0 1];                                         % 3x3 homography matrix
mapt  = imtransform2(map + 1, H, 'method', 'nearest');        % transformation (+ 1! help us to find indexes easier)
mapt  = mapt - 1;                                             % [0: occupied] [1: free] [-1: irrelevant] 

end
