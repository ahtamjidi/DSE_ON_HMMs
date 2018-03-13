function distance = ClosenessMeasures(p1,p2)

    % This is a function that calculates various measures of closeness between
    % two discrete probability distributions. p1 and p2 are two n*1 vectors and
    % the distance structure has fileds containing a particular distance
    % measrure. For example distance.BCS cotains the Bhattacharyya distance
    % between p1 and p2

    %% Initial Tests
%     if sum(p1)>1
%         warning('p1 not normalized. It will be normalized before distance calculation');
%         p1 = p1./sum(p1);
%     end
% 
%     if sum(p2)>1
%         warning('p2 not normalized. It will be normalized before distance calculation');
%         p2 = p2./sum(p2);
%     end

    %% Bhattacharyaa Distance
    distance.BCS = sum(sqrt(p1.*p2));

    %% Bhattacharyaa Distance
    distance.HEL = sqrt(1-distance.BCS);
    
    %% Tests
    % % test
    % p1 = [1 0 ]; p2 = [1,0];
    % if (sum(sqrt(p1.*p2))~=1)
    %     disp('The distance between two identical vectors should be 1')
    % end
    % p1 = [1 0 ]; p2 = [0,1];
    % if (sum(sqrt(p1.*p2))~=0)
    %     disp('The distance between two contradicting  vectors should be 0')
    % end
    % 
    % p1 = [ 0.9 0.1]; p2 = [0.7,0.3];
    % if (sum(sqrt(p1.*p2))>1)
    %     disp('The distance between two contradicting  vectors should be between 0 and 1')
    % end
end