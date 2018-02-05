function Network = CalcLikelihood(Network,Global,k)
% I will keep Global as an input. Maybe in the future it will be used

for i  = 1:Network.NumNodes
    Network.Node(i).Likelihood(:,k) = Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
end