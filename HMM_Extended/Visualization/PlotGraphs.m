function varargout = PlotGraphs(varargin)
% PlotGraphs MATLAB code for PlotGraphs.fig
%      PlotGraphs, by itself, creates a new PlotGraphs or raises the existing
%      singleton*.
%
%      H = PlotGraphs returns the handle to a new PlotGraphs or the handle to
%      the existing singleton*.
%
%      PlotGraphs('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PlotGraphs.M with the given input arguments.
%
%      PlotGraphs('Property','Value',...) creates a new PlotGraphs or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotGraphs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotGraphs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotGraphs

% Last Modified by GUIDE v2.5 19-Apr-2018 10:21:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotGraphs_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotGraphs_OutputFcn, ...
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

% --- Executes just before PlotGraphs is made visible.
function PlotGraphs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotGraphs (see VARARGIN)

if size(varargin,2)~=3
    % Choose default command line output for PlotGraphs
    handles.output = hObject;
    handles.SIMDATA = varargin;

    % Update handles structure
    guidata(hObject, handles);    
    % This sets up the initial plot - only do when we are invisible
    % so window can get raised using PlotGraphs.
    if strcmp(get(hObject,'Visible'),'off')
        plot(rand(5),'Parent',handles.axes1);
    end
    return;
end


Sim = varargin{1};
HMM = varargin{2};
Network = varargin{3};
initVal = 1; m = 1; M = Sim.EndTime;
p = plot(Network.graph{initVal}, 'Parent',handles.axes1,'Layout','circle');


MC = dtmc(HMM.MotMdl);
MCG = graphplot(handles.axes2,MC,'ColorEdges',true);
MCG.NodeColor=[0 0 0];
highlight(MCG,HMM.TrueStates(initVal),'NodeColor','red');

% Choose default command line output for PlotGraphs
handles.output = hObject;
handles.SIMDATA = varargin;
handles.GRAPH_POINTS = {p.XData,p.YData};
handles.MC = MC;
handles.MCG = MCG;

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


function slider1ContValCallback(hObject,eventdata)
    vf = get(hObject,'Value');
    v = int32(vf);
    set(hObject,'Value',v);
    set(hObject.Parent.Children(1),'String',v);
    h = guidata(hObject.Parent.Parent);
    Sim = h.SIMDATA{1};
    HMM = h.SIMDATA{2};
    Network = h.SIMDATA{3};
    XData = h.GRAPH_POINTS{1};
    YData = h.GRAPH_POINTS{2};
    g = Network.graph{v};
    plot(g, 'Parent', h.axes1, 'XData',XData, 'YData',YData);
    
    h.MCG.NodeColor=[0 0 0];
    highlight(h.MCG,HMM.TrueStates(v),'NodeColor','red');
    if v==1
    else        
    end
    
    
    
    


% UIWAIT makes PlotGraphs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotGraphs_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
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
