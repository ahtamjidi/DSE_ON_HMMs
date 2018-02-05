function [weights_ci,inf_mat,inf_vect] =calc_ci_weights_ver3(S1,local_inf_vec,method_)

nCovSamples = size(S1,3);
% global opt_dist
x0  = rand(nCovSamples,1);
x0 = x0./sum(x0);
Aeq = ones(size(x0))';
beq = 1;
lb = zeros(size(x0))';
ub = ones(size(x0))';
A =[];
b = [];
nonlcon = [];
if verLessThan('matlab','8.4')
    options = optimset('Algorithm','sqp');
    if strcmp(method_,'tr')
        x = fmincon(@cost_ci_tr,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    elseif strcmp(method_,'det')
        x = fmincon(@cost_ci_det,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    end
    % options = optimoptions('fmincon','Algorithm','sqp');
    % options = optimoptions('fmincon');
    % if strcmp(method_,'tr')
    %     x = fmincon(@cost_ci_tr,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    % elseif strcmp(method_,'det')
    %     x = fmincon(@cost_ci_det,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    % end
else
    options = optimoptions('fmincon','Display','none','Algorithm','sqp');
    if strcmp(method_,'tr')
        x = fmincon(@cost_ci_tr,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    elseif strcmp(method_,'det')
        x = fmincon(@cost_ci_det,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
    end
end

weights_ci = x;
if sum(weights_ci)>1
    log_message('sum of w more than 1 --> renormalizing');
    weights_ci = weights_ci./sum(weights_ci);
end


inf_vect = special_dot_sum(weights_ci,local_inf_vec,0);
inf_mat = calc_inf_ci(x);


    function cost_tr = cost_ci_tr(x)
        information_matrix = zeros(size(S1(:,:,1)));
        for i_tr=1:length(x)
            information_matrix = information_matrix +x(i_tr,1)*(S1(:,:,i_tr));
        end
        cost_tr = trace(inv(information_matrix));
    end
    function cost_tr = cost_ci_det(x)
        information_matrix = zeros(size(S1(:,:,1)));
        for i_det=1:length(x)
            information_matrix = information_matrix +x(i_det,1)*(S1(:,:,i_det));
        end
        cost_tr = -log(det(information_matrix));
        if isinf(cost_tr)
            cost_tr = log(det(inv(information_matrix)));
        end
    end

    function [information_matrix] = calc_inf_ci(x)
        information_matrix = zeros(size(S1(:,:,1)));
        for i_det=1:length(x)
            information_matrix = information_matrix +x(i_det,1)*(S1(:,:,i_det));
        end
        information_matrix = 0.5*(information_matrix+information_matrix');
    end


end
