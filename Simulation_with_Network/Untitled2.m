s1.b1=1;
s1.b2=5;
s2=s1;
s3=s1;
s=[s1 s2 s3];
for i= 1:size([s1 s2 s3],2);
    s(i).b1=10;
end

