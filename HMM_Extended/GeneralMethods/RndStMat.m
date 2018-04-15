function [StMat] = RndStMat(NumStates,DiagRng)  
% Returns a right stochastic matrix with diagonal entries are random but in the range given by DiagRng
    StMat = zeros(NumStates);
    StMat(eye(NumStates)==0)=nan;
    StMat=StMat+diag(min(DiagRng)+diff(sort(DiagRng))*rand(NumStates,1));
    mc = mcmix(NumStates,'Fix',StMat);
    StMat = mc.P; 
end