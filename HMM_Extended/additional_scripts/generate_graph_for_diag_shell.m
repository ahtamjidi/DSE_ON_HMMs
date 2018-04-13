function [flag_coon,G] = generate_graph_for_diag_shell(idx_reg,n_degree_graph,prob_of_link_fail)
thresh = prob_of_link_fail;
% idx_reg = 4;
for i_reg=1:length(idx_reg)
    flag_coon_before=0;
    count_try = 0;
    while ~flag_coon_before
    eln = kregular(n_degree_graph,idx_reg(i_reg));
    adj_tri = zeros(n_degree_graph,n_degree_graph);
    idx = sub2ind(size(adj_tri), eln(:,1)', eln(:,2)');
    adj_tri(idx)=1;
%     thresh = i_res/res_diag;
      flag_coon_before = isconnected(adj_tri);
      count_try = count_try+1;
      if count_try>1
          disp('try more than once')
      end
    end
    rand_mask = rand(n_degree_graph,n_degree_graph);
    
    adj_ = double(or(adj_tri.*rand_mask>=thresh,eye(n_degree_graph)));
    tri_u1 = ([triu(adj_,1)' + triu(adj_)]);
    adj_ = tri_u1;
    flag_coon = isconnected(adj_);
    G = generate_graph(adj_);
end