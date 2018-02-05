clear all
close all
clc
granularity = 0.1;
nSamples = 100;
prob_of_link_fail = [0:granularity:1];
flag_full_disconnectivity = zeros(length(prob_of_link_fail),nSamples);

for iProb =1:length(prob_of_link_fail)
    for isample=1:nSamples
        [flag_coon(iProb,isample),G] = generate_graph_for_HMM(2,15,prob_of_link_fail(iProb));
        if (nnz(G.d==2) == 15)
            flag_full_disconnectivity(iProb,isample) = 1;
        end
    end
    percent(iProb) = 100*(nnz(flag_coon(iProb,:)))/nSamples;
    percent2(iProb) = 100*(nSamples - nnz(flag_full_disconnectivity(iProb,:)))/nSamples;
    
end
figure
plot(prob_of_link_fail,percent2);