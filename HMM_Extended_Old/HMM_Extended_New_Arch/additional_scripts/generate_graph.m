function G = generate_graph(Adj)
nv = size(Adj,2);
G.Adj =Adj;
for i=1:nv
    G.d(i) = sum(G.Adj(i,:))+1;
end


for i=1:nv
    for j=1:nv
        if G.Adj(i,j)~=0
            if i~=j
                G.p(i,j) = min(1/G.d(i),1/G.d(j));
            end
            if i==j
                %                 G.p(i,j) =  calc_p_ii(G.d(:).*G.Adj(:,i),i);
            end
        else
            G.p(i,j) = 0;
        end
        
    end
end

for i=1:nv
    G.p(i,i) = 1-sum(G.p(i,:));
end


end
