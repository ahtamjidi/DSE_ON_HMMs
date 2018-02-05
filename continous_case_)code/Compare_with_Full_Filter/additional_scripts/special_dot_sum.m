function sum_ = special_dot_sum(w,matrix_,flag_inverse)
% matrix_ is n * l * m
% w is 1 * m
n = size(matrix_,1);
l = size(matrix_,2);
sum_  = zeros(n,l);
if flag_inverse
    for i=1:numel(w)
        if w(i)~=0
            sum_ = sum_ + w(i).* inv(matrix_(:,:,i));
        end
    end
else
    for i=1:numel(w)
        if w(i)~=0
            sum_ = sum_ + w(i).* matrix_(:,:,i);
        end
    end
end
end