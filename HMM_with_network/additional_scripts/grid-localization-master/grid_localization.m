function [ pkt ] = grid_localization( pkt_d1, ut, zt, m, motion_params, measurement_params )
%GRID_LOCALIZATION A localizer using the discrete Bayes filter
%   Using stochastic motion and measurement models, localize the Thrunbot
%   based on a discrete Bayes filter. Here we use the Odometry Motion Model
%   (p. 134) and the Range Finder Measurement Model (p. 158).
%
%   Remember that:
%       motion_model == p(xt | ut, xt_d1)
%       measurement_model = p(zt | xt, m)
%
%   Probabilistic Robotics, Thrun et al., p 238, Table 8.1

    % What is the size of this map?
    N = size(m,1); % num of rows and columns (it's square)
    depth = 4; % theta = 0, 90, 180, 270
    count = N*N*depth; % how many cells are there?
    
    % Initialize variables
    pbarkt = zeros([size(m) depth]);
    pkt = zeros([size(m) depth]);
    
    % This variable is for debugging. It helped me know to not flip the
    % probability matrix inside showProbabilities().
    p = zeros(count, 5); % each row: [p(zt|xt,m) zt [x y theta]]
       
    for k = 1:count % line 2 of Table 8.1
        
        % pick a new hypothesis of were the successor pose will be
        % (i.e., what's the probability of being at xt given that I
        % was initially at xt_d1 and my encoders said I went ut
        [rowk, colk, depthk] = ind2sub([N N depth], k);
        xt = ind2state([N N depth], k);
        
        % No need to check if the hypothesis is on an obstacle
        if (is_occupied(xt, m)), continue; end
        
        % -- Prediction ---------------------------------------------------
        for i = 1:count % line 3 of Table 8.1
            
            % pick a new initial pose to test
            [rowi, coli, depthi] = ind2sub([N N depth], i);
            xt_d1 = ind2state([N N depth], i);
            
            pbarkt(rowk,colk,depthk) = pbarkt(rowk,colk,depthk) + ...
                pkt_d1(rowi,coli,depthi)*...
                    motion_model_with_map(xt,ut,xt_d1,m,motion_params);
        end
        % -----------------------------------------------------------------
        
        % -- Measurement update -------------------------------------------
        p(k,:)=[beam_range_finder_model(zt,xt,m,measurement_params) zt xt];
        pkt(rowk,colk,depthk) = pbarkt(rowk,colk,depthk)*p(k,1);% line 4
        % note that there is no eta -- that normalization is done at the
        % end of this function
        % -----------------------------------------------------------------
        
    end
    
    % Normalize probability to sum to 1.
    pkt = pkt/sum(pkt(:));

    % Show the before (fig 3) and after (fig 4) motion models. i.e., these
    % two plots show the probability of being in different positions based
    % on where Thrunbot was before, and what the motion command was.
    showProbabilities(3,pkt_d1,ut(1:3)); % bel(xt_d1)
    showProbabilities(4,pbarkt,ut(4:6)); % shows the prediction step
    
    % restructure p to plot p(zt={zt}|xt,m)
    pzt = reshape(p(:,1),[N N depth]);
    pzt = pzt/sum(pzt(:)); % normalize
    showProbabilities(5,pzt,ut(4:6)); % shows the measurement probabilities
end

function flag = is_occupied(xt, m)
%IS_OCCUPIED Is there an obstacle at this pose in the map?

    [i, j, ~] = state2sub(xt, m);
    flag = (m(i, j) == 1);
end

function p = motion_model_with_map( xt, ut, xt_d1, m, motion_params )
%MOTION_MODEL_WITH_MAP Use the map to prevent motion through walls
%   pmap = p(xt | m) and pmotion = p(xt | ut, xt_d1).
%   See Table 5.7, p. 141

    % Probability of being in a state, given the map of obstacles
    if is_occupied(xt, m)
        pmap = 0;
    else
        % how many spots in the map?
        count = size(m,1)*size(m,2);
        
        % how many obstacles in the map are there?
        obstacle_count = sum(m(:));
        
        % how many spots could Thrunbot be?
        N = count - obstacle_count;
        
        % If it's equally likely for Thrunbot to be in a non-obstacle spot,
        % what's the probability of being in the given xt?        
        pmap = 1/N;
    end
    
    pmotion = motion_model_odometry(xt,ut,xt_d1,motion_params);
    
    p = pmotion*pmap; % line 2
    
    % Probably need to do some normalization?
    % Or is that built in to the end of grid_localization?
end