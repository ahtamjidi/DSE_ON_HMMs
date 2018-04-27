for i = 1:k   
    pause(.2);
    plot(Network.graph{i},'Layout','circle')
    drawnow
end