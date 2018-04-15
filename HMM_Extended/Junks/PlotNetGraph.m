function PlotNetGraph(Sim,Network)
    close all
    m = 1;
    M = Sim.EndTime;
    initVal = 5;
%     g = Network.graph{i};
    f = figure;
    ax = axes('Parent',f,'position',[0.1 0.28  0.9 0.7]);
%     p = plot(g);
    b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],'value',initVal, 'min',m, 'max',M,'SliderStep',[1/M 1/M]);
    h = guidata(f);
    b.addlistener('ContinuousValueChange',@(hFigure,eventdata) slider1ContValCallback(hFigure,eventdata));
    bgcolor = f.Color;
    bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],'String',int2str(m),'BackgroundColor',bgcolor);
    bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],'String',int2str(M),'BackgroundColor',bgcolor);
    bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],'String',int2str(initVal),'BackgroundColor',bgcolor);    
end
function slider1ContValCallback(hObject,eventdata)
    v = get(hObject,'Value');
    fprintf('slider value: %f\n',v);
    set(hObject,'Value',int32(v));
end