function [Network] = NGMD(Global,Network,k)
% Our approach: Conservative fusion of priors + Consensus over current
% Observations (#4)

% iterative conservative fusion of priors
Network = IterativeConservativeFusion(Network,Global,'GMD',k);

% prediction 
Network = predict(Network,Global,k);

% calculating the likelihood based on prediction 
Network = CalcLikelihood(Network,Global,k);

% iterative consensus
Network = IterativeConsensus(Network,Global,'GMD',k);

% update 
Network = EstimateUpdate(Network,Global,'GMD',k);

% process and performance evaluation


end