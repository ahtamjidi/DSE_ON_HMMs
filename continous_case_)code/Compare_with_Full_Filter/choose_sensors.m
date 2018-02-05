function [C,ind_sensor] = choose_sensors(Ct,nSensor)
norm_c = zeros(size(Ct,1),1);
for i = 1 : size(Ct,1)
    norm_c(i) = sum(abs(Ct(i,:)));
end

[B,ind] = sort(norm_c,'descend');
% eig(Ct(ind(1:10),:)*At)
% 
% G = ss(At,Bt,Ct(ind(1:1),:),[],1)
% Gc = canon(G,'modal');
% Gc.A
% Gc.C
ind_sensor = ind(1:nSensor);
C = Ct(ind(1:nSensor),:);