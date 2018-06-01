function varargout = PlotGrid(varargin)
% PlotGrid MATLAB code for PlotGrid.fig
%      PlotGrid, by itself, creates a new PlotGrid or raises the existing
%      singleton*.
%
%      H = PlotGrid returns the handle to a new PlotGrid or the handle to
%      the existing singleton*.
%
%      PlotGrid('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PlotGrid.M with the given input arguments.
%
%      PlotGrid('Property','Value',...) creates a new PlotGrid or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotGrid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotGrid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotGrid

% Last Modified by GUIDE v2.5 29-Apr-2018 11:47:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotGrid_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotGrid_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before PlotGrid is made visible.
function PlotGrid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotGrid (see VARARGIN)

if size(varargin,2)~=3
    % Choose default command line output for PlotGrid
    handles.output = hObject;
    handles.SIMDATA = varargin;

    % Update handles structure
    guidata(hObject, handles);    
    % This sets up the initial plot - only do when we are invisible
    % so window can get raised using PlotGrid.
    if strcmp(get(hObject,'Visible'),'off')
        plot(rand(5),'Parent',handles.Ax1);
    end
    return;
end


Sim = varargin{1};
HMM = varargin{2};
Network = varargin{3};

initVal = 1; m = 1; M = Sim.EndTime;



set(handles.Ax1,'xtick',[]);
set(handles.Ax1,'ytick',[]);

% Choose default command line output for PlotGrid
handles.output = hObject;
handles.SIMDATA = varargin;
handles.Vis = InitVis(Sim,HMM,Network,handles.Ax1);
handles.Vis = VisStep(Sim,HMM,Network,handles.Vis,initVal);

hAx = [handles.Ax11 handles.Ax12 handles.Ax21 handles.Ax22];
hEd = [handles.E11 handles.E12 handles.E21 handles.E22];
for i=1:length(hAx)
    EE = int32(str2double(hEd(i).String));
    axis(hAx(i),'square');
    set(hAx(i),'xtick',[]);
    set(hAx(i),'ytick',[]);
    axis(hAx(i),[0 handles.Vis.xLen 0 handles.Vis.yLen]);
    im = ProcPMFs(Sim,Network,initVal,int32(EE/10),mod(EE,10));
    handles.hIm(i) = imagesc(hAx(i),'CData',im,[0 1]);
end




% Update handles structure
guidata(hObject, handles);

set(handles.slider1,'value',initVal);
set(handles.slider1,'min',m);
set(handles.slider1,'max',M);
set(handles.slider1,'SliderStep',[1/M 1/M]);

set(handles.text1,'String',num2str(m));
set(handles.text2,'String',num2str(M));
set(handles.text3,'String',num2str(initVal));
handles.slider1.addlistener('ContinuousValueChange',@(hFigure,eventdata) slider1ContValCallback(hFigure,eventdata));


function im = ProcPMFs(Sim,Network,t,n,type)
    im=zeros(Sim.World.n_r,Sim.World.n_c);
    for i = 1:Sim.NumStates
        [x,y] = find(Sim.World.StatesGrid == i);
        r = .25;
        if type == 1
            im(x,y) = 1- Network.Node(n).HYB_Est.Post(i,t)^r;
        elseif type == 2
            im(x,y) = 1- Network.Node(n).ICF_Est.Post(i,t)^r;
        elseif type == 3
            im(x,y) = 1- Network.Node(n).FHS_Est.Post(i,t)^r;
        else
            im(x,y) = 1- Network.CEN_Est.Post(i,t)^r;
        end
    end
    im = flipud(im);

function slider1ContValCallback(hObject,eventdata)
    vf = get(hObject,'Value');
    v = int32(vf);
    set(hObject,'Value',v);
    set(hObject.Parent.Children(1),'String',v);
    h = guidata(hObject.Parent.Parent);
    Sim = h.SIMDATA{1};
    HMM = h.SIMDATA{2};
    Network = h.SIMDATA{3};
    h.Vis = VisStep(Sim,HMM,Network,h.Vis,v);
    guidata(hObject.Parent.Parent, h); 
    
%     E11 = int32(str2double(h.E11.String));
%     axis(h.Ax11,'square');
%     set(h.Ax11,'xtick',[]);
%     set(h.Ax11,'ytick',[]);
%     axis(h.Ax11,[0 h.Vis.xLen 0 h.Vis.yLen]);
%     h.im11.CData = ProcPMFs(Sim,Network,v,int32(E11/10),mod(E11,10));

    hAx = [h.Ax11 h.Ax12 h.Ax21 h.Ax22];
    hEd = [h.E11 h.E12 h.E21 h.E22];
    for i=1:length(hAx)
        EE = int32(str2double(hEd(i).String));
        im = ProcPMFs(Sim,Network,v,int32(EE/10),mod(EE,10));
        h.hIm(i).CData = im;
    end
    
    
    


% UIWAIT makes PlotGrid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotGrid_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.Ax1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

    

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function E11_Callback(hObject, eventdata, handles)
% hObject    handle to E11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E11 as text
%        str2double(get(hObject,'String')) returns contents of E11 as a double


% --- Executes during object creation, after setting all properties.
function E11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E21_Callback(hObject, eventdata, handles)
% hObject    handle to E21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E21 as text
%        str2double(get(hObject,'String')) returns contents of E21 as a double


% --- Executes during object creation, after setting all properties.
function E21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E12_Callback(hObject, eventdata, handles)
% hObject    handle to E12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E12 as text
%        str2double(get(hObject,'String')) returns contents of E12 as a double


% --- Executes during object creation, after setting all properties.
function E12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function E22_Callback(hObject, eventdata, handles)
% hObject    handle to E22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of E22 as text
%        str2double(get(hObject,'String')) returns contents of E22 as a double


% --- Executes during object creation, after setting all properties.
function E22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
