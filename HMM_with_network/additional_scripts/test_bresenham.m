[x, y]=bresenham(1,1,30,10);
b = zeros(40,40);
for i = 1:length(x)
    b(x(i),y(i)) = 1;
end
imagesc(b);