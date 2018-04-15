function varargout = NetGraph(varargin)
% NETGRAPH MATLAB code for NetGraph.fig
%      NETGRAPH, by itself, creates a new NETGRAPH or raises the existing
%      singleton*.
%
%      H = NETGRAPH returns the handle to a new NETGRAPH or the handle to
%      the existing singleton*.
%
%      NETGRAPH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NETGRAPH.M with the given input arguments.
%
%      NETGRAPH('Property','Value',...) creates a new NETGRAPH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NetGraph_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NetGraph_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NetGraph

% Last Modified by GUIDE v2.5 15-Apr-2018 02:12:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NetGraph_OpeningFcn, ...
                   'gui_OutputFcn',  @NetGraph_OutputFcn, ...
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

% --- Executes just before NetGraph is made visible.
function NetGraph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NetGraph (see VARARGIN)

Sim = varargin{1};
Network = varargin{2};
n = Network.NumNodes;
A = ones(n) - diag(ones(1,n));
G = graph(A~=0);
p = plot(G, 'Parent',handles.axes1);

% Choose default command line output for NetGraph
handles.output = hObject;
handles.SIMDATA = varargin;
handles.GRAPH_POINTS = {p.XData,p.YData};


% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using NetGraph.
if strcmp(get(hObject,'Visible'),'off')
    %plot(rand(5));
end

initVal = 1; m = 1; M = Sim.EndTime;
set(handles.slider1,'value',initVal);
set(handles.slider1,'min',m);
set(handles.slider1,'max',M);
set(handles.slider1,'SliderStep',[1/M 1/M]);

set(handles.text1,'String',num2str(m));
set(handles.text2,'String',num2str(M));
set(handles.text3,'String',num2str(initVal));
handles.slider1.addlistener('ContinuousValueChange',@(hFigure,eventdata) slider1ContValCallback(hFigure,eventdata));
g = Network.graph{int32(initVal)};
plot(g, 'Parent', handles.axes1, 'XData',p.XData, 'YData',p.YData);

function slider1ContValCallback(hObject,eventdata)
    v = get(hObject,'Value');
    set(hObject,'Value',int32(v));
    set(hObject.Parent.Children(1),'String',int32(v));
    h = guidata(hObject.Parent.Parent);
    Sim = h.SIMDATA{1};
    Network = h.SIMDATA{2};
    XData = h.GRAPH_POINTS{1};
    YData = h.GRAPH_POINTS{2};
    g = Network.graph{int32(v)};
    plot(g, 'Parent', h.axes1, 'XData',XData, 'YData',YData);
    
    


% UIWAIT makes NetGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NetGraph_OutputFcn(hObject, eventdata, handles)
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
