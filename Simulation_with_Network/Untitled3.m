% close all
% clear all %#ok<CLALL>
% load DATA_final.mat
% SetConfig(World);
im1 = 1*ones(25,25);
im2 = 1*ones(25,25);

% a = [0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
for t = 1:size(Sim.GT,2)
    if t == 1
        subplot(2,3,[1 2 4 5]);
        Vis = InitVis(World,Sim,Net_CEN);
        mTextBox = uicontrol('style','text');
    end
    for i = 1:World.NumStates
        [x,y] = find(World.StatesGrid == i);
        im1(x,y) = Net_NGMD.Node(3).Post(i,t)^.5;
        im2(x,y) = Net_NGMD.Node(5).Post(i,t)^.5;
    end
    
   
    set(mTextBox,'String','Hello World')
    if ~a(t)
%         Graph = generate_graph([1 1 0 0 0 0; 1 1 1 0 0 0 ;0 1 1 1 0 0; 0 0 1 1 1 0;0 0 0 1 1 1;0 0 0 0 1 1]);
        set(mTextBox,'String','Connected');
        %connected
    else
%         Graph = generate_graph([1 1 0 0 0 0; 1 1 1 0 0 0 ;0 1 1 1 0 0; 0 0 1 1 0 0;0 0 0 0 1 1;0 0 0 0 1 1]);
         set(mTextBox,'String','Disconnected');
        %disconnected
    end
    
    subplot(2,3,3);
    imagesc(1-im1,[0 1]);
    colormap gray
    axis square    
    hold on
    for k=1:6
        plot(Net_NGMD.Node(k).Pos(t,2),Net_NGMD.Node(k).Pos(t,1),'*','MarkerSize',10,'color','red');
    end
    hold off

    subplot(2,3,6);
    imagesc(1-im2,[0 1]);
    colormap gray
    axis square    
    hold on
    for k=1:6
        plot(Net_NGMD.Node(k).Pos(t,2),Net_NGMD.Node(k).Pos(t,1),'*','MarkerSize',10,'color','red');
    end
    hold off
    VisStep(World,Sim,Net_CEN,Vis,t);
    waitforbuttonpress;
%     pause(.5);
end