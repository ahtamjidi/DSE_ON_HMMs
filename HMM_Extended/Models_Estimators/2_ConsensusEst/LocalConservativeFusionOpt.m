function ICF = LocalConservativeFusionOpt(LocalNetwork,iConsensus,Method,k)
    nNeighbours = numel(LocalNetwork);
    if isempty(LocalNetwork)
        ICF = [];
        return;
    end
    switch Method
        case 'NGMD_ICF'
            %% Optimization
            Cost = @(omega)KLDCostFuncNGMD(omega,LocalNetwork,iConsensus,k);
            omega_0 = ones(nNeighbours,1)/nNeighbours;
            A = [];
            b = [];
            Aeq = ones(1,nNeighbours);
            beq = 1;
            lb = zeros(1,nNeighbours);
            ub = ones(1,nNeighbours);
            [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub,[],optimoptions('fmincon','Display','notify-detailed'));
            %% Update
            Prior = ones(size(LocalNetwork(1).HYB_Est.Prior(:,k)));
            for i = 1:numel(LocalNetwork)
                Prior = Prior.*LocalNetwork(i).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
            end
            ICF = Prior/sum(Prior);
        case 'NGCF_ICF'
            %% Optimization
            Cost = @(omega)KLDCostFuncNGCF(omega,LocalNetwork,iConsensus,k);
            omega_0 = ones(nNeighbours,1)/nNeighbours;
            A = [];
            b = [];
            Aeq = ones(1,nNeighbours);
            beq = 1;
            lb = zeros(1,nNeighbours);
            ub = ones(1,nNeighbours);
            [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub,[],optimoptions('fmincon','Display','notify-detailed'));
            %% Update
            Post = ones(size(LocalNetwork(1).ICF_Est.Post(:,k)));
            for i = 1:numel(LocalNetwork)
                Post = Post.*LocalNetwork(i).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
            end
            ICF = Post/sum(Post);
    end
end

function KLD_error = KLDCostFuncNGMD(omega,LocalNetwork,iConsensus,k)
    Prior = ones(size(LocalNetwork(1).HYB_Est.Prior(:,k)));
    for i = 1:numel(LocalNetwork)
        Prior = Prior.*LocalNetwork(i).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
    end
    Prior = Prior/sum(Prior);
    D_kl = zeros(1,numel(LocalNetwork));
    for i = 1:numel(LocalNetwork)
        D_kl(i) = kullback(Prior,LocalNetwork(i).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus-1));
    end
    KLD_error = max(D_kl);
end

function KLD_error = KLDCostFuncNGCF(omega,LocalNetwork,iConsensus,k)
    Post = ones(size(LocalNetwork(1).ICF_Est.Prior(:,k)));
    for i = 1:numel(LocalNetwork)
        Post = Post.*LocalNetwork(i).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^omega(i);
    end
    Post = Post/sum(Post);
    D_kl = zeros(1,numel(LocalNetwork));
    for i = 1:numel(LocalNetwork)
        D_kl(i) = kullback(Post,LocalNetwork(i).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus-1));
    end
    KLD_error = max(D_kl);
end
