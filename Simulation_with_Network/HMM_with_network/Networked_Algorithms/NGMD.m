function [Network] = NGMD(Network,HMM,k)
% Our approach: Conservative fusion of priors + Consensus over current
% Observations (#4)

% iterative conservative fusion of priors
Network = IterativeConservativeFusion(Network,'GMD',k);

% prediction 
Network = predict(Network,HMM,k);

% calculating the likelihood based on prediction 
Network = CalcLikelihood(Network,k);

% iterative consensus
Network = IterativeConsensus(Network,'GMD',k);

% update 
Network = EstimateUpdate(Network,'GMD',k);

% process and performance evaluation


end