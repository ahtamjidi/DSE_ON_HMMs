function ObsMdl = GenObsModel(Global)
% this function generates random near diagonal observation model
diga_elements = rand(Global.SizeState,1)*0.3 + 0.7; % diagonal elements are randomly distributed around 0.7

mat = diag(diga_elements) +...
    [ zeros(Global.SizeState-1,1) , 0.1*diag(diga_elements(1:end-1,1)) ;  zeros(1,Global.SizeState)] + ...
    [ [ zeros(1,Global.SizeState-1) ; 0.1*diag(diga_elements(2:end)) ] , zeros(Global.SizeState,1) ];

rowsum = sum(mat,2);
ObsMdl = bsxfun(@rdivide, mat, rowsum);
end