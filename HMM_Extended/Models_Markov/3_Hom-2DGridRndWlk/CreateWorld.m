function [World] = CreateWorld(ImageName)
    World.ImageGrid = imread(ImageName);
    World.BinaryGrid = World.ImageGrid ~= 0;
    World.n_r = size(World.BinaryGrid,1);
    World.n_c = size(World.BinaryGrid,2);
    World.DiagLen = ceil(sqrt(World.n_r^2+World.n_c^2));
    World.StatesGrid = zeros(World.n_r,World.n_c);
    k = 1;
    for i = 1:World.n_r
        for j = 1:World.n_c
            if World.BinaryGrid(i,j) ~= 0
                World.StatesGrid(i,j) = k;
                k = k+1;
            end
        end
    end
    World.NumStates = k-1;
end