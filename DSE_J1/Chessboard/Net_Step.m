function [Net_NGMD,Net_NGCF,Net_CEN,Net_GST] = Net_Step(HMM,Net,Net_NGMD,Net_NGCF,Net_CEN,Net_GST,Sim)
    %% Update Network Graph
%     [flag_coon,Graph] = generate_graph_for_HMM(Net.RegularityDegree,Net.NumOfNodes,Net.PorbLinkFailure);
%     Graph.flag_coon = flag_coon;
    a = [0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    if ~a(Sim.MCtr)
        Graph = generate_graph([1 1 0 0 0 0; 1 1 1 0 0 0 ;0 1 1 1 0 0; 0 0 1 1 1 0;0 0 0 1 1 1;0 0 0 0 1 1]);
    else
        Graph = generate_graph([1 1 0 0 0 0; 1 1 1 0 0 0 ;0 1 1 1 0 0; 0 0 1 1 0 0;0 0 0 0 1 1;0 0 0 0 1 1]);
    end
    Net.Graph = Graph;
    Net_NGMD.Graph = Net.Graph;
    Net_NGCF.Graph = Net.Graph;
    Net_CEN.Graph = Net.Graph;
    Net_GST.Graph = Net.Graph;
    Net_GST.a = a;
    if Sim.MCtr ~= 1
        for i = 1:Net_NGMD.NumOfNodes
            Net_NGMD.Node(i).Pos(Sim.MCtr,:) = Net.Node(i).Pos(Sim.MCtr,:);
            Net_NGMD.Node(i).MoveDir = Net.Node(i).MoveDir;
            Net_NGMD.Node(i).z(Sim.MCtr) = Net.Node(i).z(Sim.MCtr);
            Net_NGMD.Node(i).ObsMdl = Net.Node(i).ObsMdl;

            Net_NGCF.Node(i).Pos(Sim.MCtr,:) = Net.Node(i).Pos(Sim.MCtr,:);
            Net_NGCF.Node(i).MoveDir = Net.Node(i).MoveDir;
            Net_NGCF.Node(i).z(Sim.MCtr) = Net.Node(i).z(Sim.MCtr);
            Net_NGCF.Node(i).ObsMdl = Net.Node(i).ObsMdl;

            Net_CEN.Node(i).Pos(Sim.MCtr,:) = Net.Node(i).Pos(Sim.MCtr,:);
            Net_CEN.Node(i).MoveDir = Net.Node(i).MoveDir;
            Net_CEN.Node(i).z(Sim.MCtr) = Net.Node(i).z(Sim.MCtr);
            Net_CEN.Node(i).ObsMdl = Net.Node(i).ObsMdl;

            Net_GST.Node(i).Pos(Sim.MCtr,:) = Net.Node(i).Pos(Sim.MCtr,:);
            Net_GST.Node(i).MoveDir = Net.Node(i).MoveDir;
            Net_GST.Node(i).z(Sim.MCtr) = Net.Node(i).z(Sim.MCtr);
            Net_GST.Node(i).ObsMdl(:,:,Sim.MCtr) = Net.Node(i).ObsMdl;
            
            Net_NGMD.Node(i).Prior(:,Sim.MCtr) = Net_NGMD.Node(i).Post(:,Sim.MCtr-1);
            Net_NGCF.Node(i).Prior(:,Sim.MCtr) = Net_NGCF.Node(i).Post(:,Sim.MCtr-1);
            Net_CEN.Node(i).Prior(:,Sim.MCtr) = Net_CEN.Node(i).Post(:,Sim.MCtr-1);
            Net_GST.Node(i).Prior(:,Sim.MCtr) = Net_GST.Node(i).Post(:,Sim.MCtr-1);
        end
    end
    Net_NGMD = NGMD(Net_NGMD,HMM,Sim.MCtr);
    Net_NGCF = NGCF(Net_NGCF,HMM,Sim.MCtr);
    Net_CEN  = CEN(Net_CEN,HMM,Sim.MCtr);
    Net_GST  = GST(Net_GST,HMM,Sim.MCtr);
end