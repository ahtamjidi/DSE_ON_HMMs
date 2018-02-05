%% load and pre-process data
%
% inputs [internal]: 
% - 'localized.data': laser end points and odometry data
%
% output: 
% - [X, Lx, Ly]:      rearrenged laser end points and estimated odometry data
%
% Alireza Asvadi, Jul. 11 2014 

function [X, Lx, Ly] = prc

%% open data
fid   = fopen('localized.data');           % Prepare data
rline = fgetl(fid);                        % Reads from file. raw line (with < char L, S, O, ... >)
%% initialize
L     = zeros(1097,720);
X     = zeros(1097,3); 
i     = 1; 
j     = 1;
%% read line by line
while ischar(rline)
%% prepare laser data
    if  sum( rline(1) == 'L' )             % get first char and see if it is L or not. Alternative: strcmp(s1,s2) 
      nrl    = str2num(rline(3:end));      % if it was L convert it to num and put it as a line in the L matrix. Number raw line (with < laser timestamp >)
      nl     = nrl(2:end);                 % number line
      L(i,:) = nl;                         % put it as a line in the mat 1 (L)
      i      = i+1;
%% prepare odometry data
    elseif sum( rline(1) == 'E' )          % get first char and see if it is X or not.
      nrl    = str2num(rline(3:end));      % if it was X convert it to num and put it as a line in the X matrix. Number raw line (with < laser timestamp >)
      nl     = nrl(2:end);                 % number line
      X(j,:) = nl;                         % put it as a line in the mat 1 (L)
      j      = j+1;
    end
%% go for next line
    rline    = fgetl(fid);                 % get new line   
end   
%% laser output
Lx    = L(:,3:4:end);                      % laser x end: number of measurements[1:1097], degrees[1:180] (1097*180)
Ly    = L(:,4:4:end);                      % laser y end  

end
