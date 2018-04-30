% function [Network,Global] = SetupAndInitialize()
% experimetn 2
%Globals vars and the Field
Global.T = 5;
Global.SizeState = 10;
Global.ConsensusIter = 15; % number of consensus iterations performed 
Network.NumNodes = 6;

Global.Graph.Params.NumNodes = Network.NumNodes; % I keep graph parameters separate in global structure
Global.Graph.Params.CoonectivityPercentage = 0.1; % a number between 0 and 1. 1 means full connectivity and 0 meanse full disconnection
Global.Graph.Params.RegularityDegree = max([min(2,Global.Graph.Params.NumNodes-1),floor(0.1*Global.Graph.Params.NumNodes)]); % Every node is connected to 10 percent of other nodes



% assign motion models 
Global.MotMdl = GenMotionModel(Global);
Global.NumStates = size(Global.MotMdl,1);
initState = 1;
%Network
% assign obserbation models
for iNode = 1:Network.NumNodes
    Network.Node(iNode).ObsMdl = GenObsModel(Global);
end
% Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
% Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];

% Network.ProbOfLinkFail = 1*ones(Global.T,1);
% Network.ProbOfLinkFail(1:2) = 0;
% Network.ProbOfLinkFail(6) = 0;
Network.ProbOfLinkFail = [0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0];

[Network,Global.GT] = HMM_SimpleSampling(Global.T,Global.MotMdl,initState,Network);

for i = 1:Network.NumNodes
    Network.Node(i).Prior = zeros(Global.SizeState,Global.T);
    Network.Node(i).Prior(initState,1) = 1;
end