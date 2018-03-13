function Cd = addboundary(c, nx, ny, nz)
Cd = zeros(ny+1,nx+1, nz +1);

for i= 2 : nx
    
    for j = 2 : ny
        for k= 1 : nz
            Cd(j,i,k) = real(c((nx-1)*(ny-1)*(k-1)+(nx - 1)*(j-2) + i-1,1));
        end
    end
    for j = ny+1
        for k = 1 : nz
        Cd(j,i,k) = 0;
        end
    end
end
    for i = nx + 1
        for j = 2 : ny
            for k = 1:nz
                Cd(j,i,k) = 0;
            end
        end
        for j = ny + 1
            for k = 1 : nz
            Cd(j,i,k) = 0;
            end
        end
    end