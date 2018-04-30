function ICF = LocalConservativeFusion(LocalNetwork,iConsensus,Method,k, Graph, iNeighbours, iNode)
nNeighbours = numel(LocalNetwork);
if isempty(LocalNetwork)
    ICF = [];
else
    switch Method
        case 'NGMD_ICF'
            %% Optimization
            %Cost = @(omega)EntropyCostFuncGMD(omega,Network,k);
            Cost = @(omega)KLDCostFuncNGMD(omega,LocalNetwork,iConsensus,k);
            omega_0 = ones(nNeighbours,1)/nNeighbours;
            A = [];
            b = [];
            Aeq = ones(1,nNeighbours);
            beq = 1;
            lb = zeros(1,nNeighbours);
            ub = ones(1,nNeighbours);
            [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
            Prior = ones(size(LocalNetwork(1).Prior(:,k)));
            for i = 1:numel(LocalNetwork)
                Prior = Prior.*LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
            end
            ICF = Prior/sum(Prior);
            
        case 'NGCF_ICF'
            %% Optimization
            %Cost = @(omega)EntropyCostFuncGMD(omega,Network,k);
            Cost = @(omega)KLDCostFuncNGCF(omega,LocalNetwork,iConsensus,k);
            omega_0 = ones(nNeighbours,1)/nNeighbours;
            A = [];
            b = [];
            Aeq = ones(1,nNeighbours);
            beq = 1;
            lb = zeros(1,nNeighbours);
            ub = ones(1,nNeighbours);
            [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
            Post = ones(size(LocalNetwork(1).Post(:,k)));
            for i = 1:numel(LocalNetwork)
                Post = Post.*LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
            end
            ICF = Post/sum(Post);
            
        case 'NGMD_VICF'
            %% No Optimization
            Prior = ones(size(LocalNetwork(1).Prior(:,k)));
            for iNhbr = 1:length(iNeighbours)
                Prior = Prior.*LocalNetwork(iNhbr).ConsesnsusData(k).ICF(:,iConsensus-1).^(Graph.p(iNode,iNeighbours(iNhbr)));
            end
            ICF = Prior/sum(Prior);
            
        case 'NGCF_VICF'
            %% Optimization
            Post = ones(size(LocalNetwork(1).Post(:,k)));
            for iNhbr = 1:length(iNeighbours)
                Post = Post.*LocalNetwork(iNhbr).ConsesnsusData(k).ICF(:,iConsensus-1).^(Graph.p(iNode,iNeighbours(iNhbr)));
            end
            ICF = Post/sum(Post);
            
    end
end
end

function KLD_error = KLDCostFuncNGMD(omega,LocalNetwork,iConsensus,k)
Prior = ones(size(LocalNetwork(1).Prior(:,k)));
for i = 1:numel(LocalNetwork)
    Prior = Prior.*LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
end
Prior = Prior/sum(Prior);
D_kl = zeros(1,numel(LocalNetwork));
for i = 1:numel(LocalNetwork)
    %     D_kl(i) = KLD(Prior,LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1)); % replaced KLD with kullback
    D_kl(i) = kullback(Prior,LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1));
    
    
end
KLD_error = max(D_kl);
end
function KLD_error = KLDCostFuncNGCF(omega,LocalNetwork,iConsensus,k)
Post = ones(size(LocalNetwork(1).Prior(:,k)));
for i = 1:numel(LocalNetwork)
    Post = Post.*LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
end
Post = Post/sum(Post);
D_kl = zeros(1,numel(LocalNetwork));
for i = 1:numel(LocalNetwork)
    %     D_kl(i) = KLD(Prior,LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1)); % replaced KLD with kullback
    D_kl(i) = kullback(Post,LocalNetwork(i).ConsesnsusData(k).ICF(:,iConsensus-1));
    
    
end
KLD_error = max(D_kl);
end
