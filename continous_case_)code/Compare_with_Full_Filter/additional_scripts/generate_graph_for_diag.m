function [flag_coon,G] = generate_graph_for_diag(idx_reg,n_degree_graph,prob_of_link_fail)
thresh = prob_of_link_fail;
% idx_reg = 4;
for i_reg=1:length(idx_reg)
    eln = kregular(n_degree_graph,idx_reg(i_reg));
    adj_tri = zeros(n_degree_graph,n_degree_graph);
    idx = sub2ind(size(adj_tri), eln(:,1)', eln(:,2)');
    adj_tri(idx)=1;
%     thresh = i_res/res_diag;
    
    rand_mask = rand(n_degree_graph,n_degree_graph);
    if (thresh==0)
        thresh = 0.0001;
    end
    adj_ = double(or(adj_tri.*rand_mask>=thresh,eye(n_degree_graph)));
    tri_u1 = ([triu(adj_,1)' + triu(adj_)]);
    adj_ = tri_u1;
    flag_coon = isconnected(adj_);
    G = generate_graph(adj_);
end