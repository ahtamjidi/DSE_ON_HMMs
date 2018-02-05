% for ii=1:numel(result.consenus)
%     con_(ii) = det(result.consenus{ii}.value{i_consensus});
% end
% figure; plot(con_)

reg_degree = 4;
n_degree_graph = 40;
fail_prob = 0;
[flag_coon,G] = generate_graph_for_diag(reg_degree,n_degree_graph,fail_prob);

eig(G.p)
x0 = rand(n_degree_graph,1)*j_agent;
for j_agent = 1 : n_degree_graph
    consenus{j_agent}.value{1} = x0(j_agent);
end

for i_consensus =2:n_degree_graph
    for j_agent = 1 : n_degree_graph
        consenus{j_agent}.value{i_consensus} = 0;
        for k_agent = 1 : n_degree_graph
            p_jk = G.p(j_agent,k_agent);
            updated_value = consenus{j_agent}.value{i_consensus} + p_jk*consenus{k_agent}.value{i_consensus-1};
            consenus{j_agent}.value{i_consensus} = updated_value;
        end
    end
end
figure;
subplot(211)
for j_agent = 1 : n_degree_graph
    con_ = [];
    for ii=1:n_degree_graph
        con_(ii) = consenus{j_agent}.value{ii};
    end
    plot(con_); hold on
end
x(:,1) = x0;
for i_consensus =2:n_degree_graph
    x(:,i_consensus) = G.p*x(:,i_consensus-1);
end
subplot(212)
for j_agent = 1 : n_degree_graph
    plot(x(j_agent,:)); hold on
end
figure
for i_consensus =2:n_degree_graph
    dx(:,i_consensus) = x(:,i_consensus)-x(:,i_consensus-1);
    dx_x(:,i_consensus) = dx(:,i_consensus)./x(:,i_consensus);
    ddx_x(:,i_consensus) = (dx_x(:,i_consensus)-dx_x(:,i_consensus-1))./x(:,i_consensus);
end 
subplot(211)
for j_agent = 1 : n_degree_graph
    plot(dx_x(j_agent,:)); hold on
end
subplot(212)
for j_agent = 1 : n_degree_graph
    plot(ddx_x(j_agent,:)); hold on
end
