function MotMdl = GenMotionModel(Global)
mat = rand(Global.SizeState, Global.SizeState);
rowsum = sum(mat,2);
MotMdl = bsxfun(@rdivide, mat, rowsum);
end
