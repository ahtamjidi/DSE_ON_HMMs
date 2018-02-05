Vis = InitVis(World,Sim,Net_CEN);
for t = 2:size(Sim.GT,2)
    VisStep(World,Sim,Net_CEN,Vis,t);
    pause(.25);
end