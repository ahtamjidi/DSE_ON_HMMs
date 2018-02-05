function consistency_percentage = consistency_percentage(x_est,x_gt,p_est)

error = x_est - x_gt;
trace = 2*sqrt(diag(p_est));
up_violate = error>trace;
down_violate = error<-trace;
consistency_percentage = 100*(nnz(up_violate) + nnz(down_violate))/numel(x_est);

