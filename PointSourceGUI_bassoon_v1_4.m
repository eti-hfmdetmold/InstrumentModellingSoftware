% contributors: Malte Kob (modeling concept, PointSourceClass), Jithin Thilakan (visualization, jupyter GUI), Walter Buchholtzer (visualization) Timo Grothe (visualization, Matlab GUI)
%

%GUI with guide for the point source modelling software
%bassoon version with 14 editable sources
%Timo Grothe, ETI, 13.03.2023

%% TODO 13.03.2023
%numbers output for Q and D
%reset button
%read from table
%stepped frequency slider

%last edit  16.05.2023: modified to reproduce the balloon plots in Fig. 6
% of the original submission

%% TODO 16.05.2023
%TODO: convert "bassoon_flow_Augustin_holes_open.mat" to a parameter table
%.csv
%buttons to switch between PS and CA model?
%file dialogue to load custom parameter tables (e.g. openwind)

%last edit  25.05.2023: modified to reproduce the three different models of the original submission
% PS, WG, WG+CA, switch between models by use of check boxes.

%% TODO 25.05.2023
%file dialogue to load custom parameter tables (e.g. openwind)
%default button for a simple point source array
%minor fixes (suggested by Jithin Thilakan)

%last edit  30.05.2023: added "reset to line array button", added "save to
%pdf" button

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% START OF GUI CONTROLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = PointSourceGUI_bassoon_v1_4(varargin)
% POINTSOURCEGUI_BASSOON_V1_4 MATLAB code for PointSourceGUI_bassoon_v1_4.fig
%      POINTSOURCEGUI_BASSOON_V1_4, by itself, creates a new POINTSOURCEGUI_BASSOON_V1_4 or raises the existing
%      singleton*.
%
%      H = POINTSOURCEGUI_BASSOON_V1_4 returns the handle to a new POINTSOURCEGUI_BASSOON_V1_4 or the handle to
%      the existing singleton*.
%
%      POINTSOURCEGUI_BASSOON_V1_4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINTSOURCEGUI_BASSOON_V1_4.M with the given input arguments.
%
%      POINTSOURCEGUI_BASSOON_V1_4('Property','Value',...) creates a new POINTSOURCEGUI_BASSOON_V1_4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PointSourceGUI_bassoon_v1_4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PointSourceGUI_bassoon_v1_4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PointSourceGUI_bassoon_v1_4

% Last Modified by GUIDE v2.5 30-May-2023 10:21:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @PointSourceGUI_bassoon_v1_4_OpeningFcn, ...
    'gui_OutputFcn',  @PointSourceGUI_bassoon_v1_4_OutputFcn, ...
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


% --- Executes just before PointSourceGUI_bassoon_v1_4 is made visible.
function PointSourceGUI_bassoon_v1_4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PointSourceGUI_bassoon_v1_4 (see VARARGIN)

global nSources
nSources = 14;
% Choose default command line output for PointSourceGUI_bassoon_v1_4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PointSourceGUI_bassoon_v1_4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% at startup of the GUI
%-initialize view
set(handles.slider110,'Min',-90,'Max',90,'Value',37.5);
set(handles.slider120,'Min',-180,'Max',180,'Value',-30);
%-load first preset (regular line array)
pushbutton9_Callback(hObject, eventdata, handles)

% --- Outputs from this function are returned to the command line.
function varargout = PointSourceGUI_bassoon_v1_4_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FREQUENCY ADJUST SLIDER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function slider100_Callback(hObject, eventdata, handles)
%% uncheck loaded presets
set(handles.checkbox1,'Value',0);
set(handles.checkbox2,'Value',0);
set(handles.checkbox3,'Value',0);
set(handles.checkbox4,'Value',0);
set(handles.checkbox5,'Value',0);
set(handles.checkbox6,'Value',0);
set(handles.checkbox7,'Value',0);
set(handles.checkbox8,'Value',0);
set(handles.checkbox9,'Value',0);
set(handles.checkbox10,'Value',0);
set(handles.checkbox11,'Value',0);
set(handles.checkbox12,'Value',0);

rearmButtons(handles)
updateGraph(handles)

function slider100_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT CONTROLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% axes reset
function pushbutton5_Callback(hObject, eventdata, handles)
set(handles.slider110,'Min',-90,'Max',90,'Value',37.5);
set(handles.slider120,'Min',-180,'Max',180,'Value',-30);
updateGraph(handles)

%% graph rotation sliders
function slider110_Callback(hObject, eventdata, handles)
updateGraph(handles)

function slider110_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider120_Callback(hObject, eventdata, handles)
updateGraph(handles)

function slider120_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% the angle resolution edit
function edit100_Callback(hObject, eventdata, handles)
updateGraph(handles)

function edit100_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% the dynamic range edit
function edit110_Callback(hObject, eventdata, handles)
updateGraph(handles)

function edit110_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UPDATE PARAMETERS (after modifications in the GUI)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% change excitation using sliders
function updateParameterTableExcitation(hObject,handles)
% to be used with SLIDER

tab0 = handles.UserData0;

%from the object tag
s = get(hObject,'tag');
%read the id of the object
sliderId = str2num(s(7:end));%disp(sliderId)
%convert it to indices in the parameter table matrix => 2 parameters(Q,D)
[i,j] = getTableIndex(2,sliderId);
%read the current parameter table matrix
tab = handles.UserData;
%update parameter table with the current value
tab(i+3,j) = tab0(i+3,j)*get(hObject,'Value'); %scale the initial value with the slider
%write the updated parameter table to the gui handles
handles.UserData = tab; %disp(tab)
%cache it
guidata(hObject, handles);

% update textfields below sliders (Q)

set(handles.text26,'String',num2str(round(tab(4,1)*100)/100));
set(handles.text27,'String',num2str(round(tab(4,2)*100)/100));
set(handles.text77,'String',num2str(round(tab(4,3)*100)/100));
set(handles.text79,'String',num2str(round(tab(4,4)*100)/100));
set(handles.text81,'String',num2str(round(tab(4,5)*100)/100));
set(handles.text83,'String',num2str(round(tab(4,6)*100)/100));
set(handles.text85,'String',num2str(round(tab(4,7)*100)/100));
set(handles.text87,'String',num2str(round(tab(4,8)*100)/100));
set(handles.text89,'String',num2str(round(tab(4,9)*100)/100));
set(handles.text91,'String',num2str(round(tab(4,10)*100)/100));
set(handles.text93,'String',num2str(round(tab(4,11)*100)/100));
set(handles.text95,'String',num2str(round(tab(4,12)*100)/100));
set(handles.text97,'String',num2str(round(tab(4,13)*100)/100));
set(handles.text99,'String',num2str(round(tab(4,14)*100)/100));

% update textfields below sliders (D)
set(handles.text28,'String',num2str(round(tab(5,1)*100)/100));
set(handles.text29,'String',num2str(round(tab(5,2)*100)/100));
set(handles.text78,'String',num2str(round(tab(5,3)*100)/100));
set(handles.text80,'String',num2str(round(tab(5,4)*100)/100));
set(handles.text82,'String',num2str(round(tab(5,5)*100)/100));
set(handles.text84,'String',num2str(round(tab(5,6)*100)/100));
set(handles.text86,'String',num2str(round(tab(5,7)*100)/100));
set(handles.text88,'String',num2str(round(tab(5,8)*100)/100));
set(handles.text90,'String',num2str(round(tab(5,9)*100)/100));
set(handles.text92,'String',num2str(round(tab(5,10)*100)/100));
set(handles.text94,'String',num2str(round(tab(5,11)*100)/100));
set(handles.text96,'String',num2str(round(tab(5,12)*100)/100));
set(handles.text98,'String',num2str(round(tab(5,13)*100)/100));
set(handles.text100,'String',num2str(round(tab(5,13)*100)/100));

updateGraph(handles)
rearmButtons(handles)
rearmCheckboxes(handles)


%% change source position using edit fields
function updateParameterTablePosition(hObject,handles)
% to be used with EDIT

%from the object tag
s = get(hObject,'tag');
%read the id of the object
editId = str2num(s(5:end));%disp(editId)
%convert it to indices in the parameter table matrix => 3 parameters(x,y,z)
[i,j] = getTableIndex(3,editId);
%read the current parameter table matrix
tab = handles.UserData;
%update parameter table with the current value
tab(i,j) = str2num(get(hObject,'String'));
%write the updated parameter table to the gui handles
handles.UserData = tab; %disp(tab)
%cache it
guidata(hObject, handles);

updateGraph(handles)
rearmButtons(handles)
rearmCheckboxes(handles)

function [rowIndex,colIndex] = getTableIndex(nparam,objectID)
%% read the consecutive objectID
%% and return the corresponding index in the parameter table
global nSources

%the coordinates parameter table is organized in three coordinates per source
%thus it has dimensions (3 x nSources)
s = [nparam,nSources];
[rowIndex,colIndex] = ind2sub(s,objectID);

% the row index corresponds to the coordinates
% rowIndex = 1 => x
% rowIndex = 2 => y
% rowIndex = 3 => z

% the column index is the number of the source

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAKE BALLOON PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function updateGraph(handles)
%% produces a balloon plot of Levels [dB] on an equiangular spherical grid
%% with angleStep resolution

%resolution of the grid
angleStep = str2num(handles.edit100.String);

%source parameters required for PointSourceClass.m
tab = handles.UserData;
% X  = tab(1,:);%x-distance of tonehole in m
% Y  = tab(2,:);%y-distance of tonehole in m
% Z  = tab(3,:);%z-distance of tonehole in m
% Q  = tab(4,:);% "amplitude of oscillator"
% D  = tab(5,:);% "acoustic waveguide distance from reed to tonehole"

%frequency [Hz] (log scaled slider)
scfreq = get(handles.slider100,'Value');
freq = 10^((log10(20000)-log10(50))*scfreq + log10(50));
%give the frequency information back to user as text
set(handles.text17,'string',[num2str(round(freq)),' Hz'])

%% if the CA model is chosen, we send a flag to modelling
if any([strcmp(get(handles.checkbox9,'Enable'),'off'),...
        strcmp(get(handles.checkbox10,'Enable'),'off'),...
        strcmp(get(handles.checkbox11,'Enable'),'off'),...
        strcmp(get(handles.checkbox12,'Enable'),'off')]);
    flag = 1;
else
    flag = 0;
end

%apply to model
[THETA,PHI,P] = modelling(angleStep,tab,freq,flag);

%% 3D ballon plot
colormap(parula)

%dynamics of the plot
dBrange = str2num(handles.edit110.String);

az = get(handles.slider120,'Value');
el = get(handles.slider110,'Value');


SPL=20*log10(abs(P)./2e-5);
maxL = max(max(SPL));
L = SPL-maxL+dBrange;
L(L<0) = 0;
[Xplot,Yplot,Zplot] = sph2cart(THETA,PHI,abs(L));

%mesh(Xplot,Yplot,Zplot,'facecolor','none')
if floor(abs(angleStep-1))
    surf(Xplot,Yplot,Zplot,abs(L),'facecolor','interp','edgecolor',[0.8 0.8 0.8])
else
    surf(Xplot,Yplot,Zplot,abs(L),'facecolor','interp','edgecolor','none')
end
caxis([0 dBrange]);
axis equal
xlabel('x'),ylabel('y'),zlabel('z')
view([az,el])

hcb = colorbar; ylabel(hcb,'[dB]');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SOURCE CONTROLS  (edit: position / sliders: excitation)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SOURCE #1
%% position
function edit1_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit2_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider1_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)
updateGraph(handles)

function slider1_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider2_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)
updateGraph(handles)

function slider2_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #2
%% position
function edit4_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit5_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit6_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider3_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider3_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider4_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider4_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% SOURCE #3
%% position
function edit7_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit9_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider5_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider5_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider6_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider6_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% SOURCE #4
%% position
function edit10_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit10_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit11_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit11_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit12_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider7_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider7_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider8_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider8_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% SOURCE #5
%% position
function edit13_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit15_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit15_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider9_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider9_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider10_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #6
%% position
function edit16_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit16_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit17_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit17_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit18_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit18_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider11_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider11_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider12_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider12_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #7
%% position
function edit19_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit19_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit20_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit20_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit21_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit21_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider13_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider13_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider14_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider14_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



%% SOURCE #8
%% position
function edit22_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit22_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit23_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit23_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit24_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit24_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider15_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider15_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider16_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider16_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



%% SOURCE #9
%% position
function edit25_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit25_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit26_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit26_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit27_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit27_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider17_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider17_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider18_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider18_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #10
%% position
function edit28_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit28_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit29_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit29_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit30_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit30_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider19_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider19_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider20_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider20_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #11
%% position
function edit31_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit31_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit32_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit32_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit33_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit33_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider21_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider21_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider22_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider22_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% SOURCE #12
%% position
function edit34_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit34_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit35_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit35_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit36_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit36_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider23_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider23_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider24_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider24_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% SOURCE #13
%% position
function edit37_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit37_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit38_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit38_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit39_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit39_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider25_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider25_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider26_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider26_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% SOURCE #14
%% position
function edit40_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit40_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit41_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit41_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit42_Callback(hObject, eventdata, handles)
updateParameterTablePosition(hObject,handles)

function edit42_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% excitation
function slider27_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider27_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider28_Callback(hObject, eventdata, handles)
updateParameterTableExcitation(hObject,handles)

function slider28_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD PRESET CHECKBOXES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 176;
    model = 'PS';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox1,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox2_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 612;
    model = 'PS';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox2,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox3_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 940;
    model = 'PS';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox3,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox4_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 1520;
    model = 'PS';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox4,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox5_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 176;
    model = 'WG';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox5,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox6_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 612;
    model = 'WG';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox6,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox7_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 940;
    model = 'WG';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox7,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox8_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 1520;
    model = 'WG';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox8,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox9_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 176;
    model = 'CA';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox9,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox10_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%re-enable file import button

%if user checks box:
if get(hObject,'Value')
    freq0 = 612;
    model = 'CA';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox10,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

% --- Executes on button press in checkbox1.
function checkbox11_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 940;
    model = 'CA';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox11,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox12,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end

function checkbox12_Callback(hObject, eventdata, handles)
%re-enable buttons for parameter import
rearmButtons(handles)
%if user checks box:
if get(hObject,'Value')
    freq0 = 1520;
    model = 'CA';
    %...load parameters
    handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
    
    set(handles.checkbox12,'Enable','off');
    %...uncheck all other boxes
    set(handles.checkbox1,'Value',0,'Enable','on');
    set(handles.checkbox2,'Value',0,'Enable','on');
    set(handles.checkbox3,'Value',0,'Enable','on');
    set(handles.checkbox4,'Value',0,'Enable','on');
    set(handles.checkbox5,'Value',0,'Enable','on');
    set(handles.checkbox6,'Value',0,'Enable','on');
    set(handles.checkbox7,'Value',0,'Enable','on');
    set(handles.checkbox8,'Value',0,'Enable','on');
    set(handles.checkbox9,'Value',0,'Enable','on');
    set(handles.checkbox10,'Value',0,'Enable','on');
    set(handles.checkbox11,'Value',0,'Enable','on');
    
    guidata(hObject,handles)
    %... update graph
    updateGraph(handles)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD FILE BUTTON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, ~, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton8,'Enable','off');
rearmCheckboxes(handles)
set(handles.pushbutton9,'Enable','on');

freq0 = 100;
model = 'PS';
handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
updateGraph(handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESET TO LINEARRAY BUTTON 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton8.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton9,'Enable','off');
rearmCheckboxes(handles)
set(handles.pushbutton8,'Enable','on','String','load file');
freq0 = 100;
model = 'PS';
handles = assignParameterTableToGUIControls(hObject, handles,freq0,model);
updateGraph(handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SAVE TO FILE BUTTON
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prompt = {'type filename'};
dlgtitle = 'save to pdf';
dims = [1 55];
definput = {'myfile'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
if isempty(answer)
else
    if strcmp(answer{1},definput{1})
        dt = datestr(now,31); dt(11) = '_'; dt([14,17]) = '-';
        answer = {[definput{1},'(',dt,')']};
    end
    filename = answer{1};
    warning off
    orient(gcf,'landscape')
    print(gcf,'-dpdf',filename)
    warning on
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GUI HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function rearmCheckboxes(handles)
set(handles.checkbox1,'Value',0,'Enable','on');
set(handles.checkbox2,'Value',0,'Enable','on');
set(handles.checkbox3,'Value',0,'Enable','on');
set(handles.checkbox4,'Value',0,'Enable','on');
set(handles.checkbox5,'Value',0,'Enable','on');
set(handles.checkbox6,'Value',0,'Enable','on');
set(handles.checkbox7,'Value',0,'Enable','on');
set(handles.checkbox8,'Value',0,'Enable','on');
set(handles.checkbox9,'Value',0,'Enable','on');
set(handles.checkbox10,'Value',0,'Enable','on');
set(handles.checkbox11,'Value',0,'Enable','on');
set(handles.checkbox12,'Value',0,'Enable','on');

function rearmButtons(handles)
set(handles.pushbutton8,'Enable','on','String','load file');
set(handles.pushbutton9,'Enable','on');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PASS VALUES FROM PRESET TO GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function handles = assignParameterTableToGUIControls(hObject,handles,freq0,model)
global nSources
if nargin < 4
    model = 'WG';
end

%% SCENARIO 1 ("reset" button has been pressed)
%% => load multipole array
if strcmp(get(handles.pushbutton9,'Enable'),'off')
    
      tabfile = zeros(nSources,5);
      tabfile(:,2) = round(linspace(1,-1,nSources)*100)/100;
      tabfile([1:7],4) = [1]; tabfile([8:14],4) = [-1];
      tabfile(:,5) = [1];

%       %dipole example (write to external file example)
%       tabfile = zeros(nSources,5);
%       tabfile([1,2],2) = [1 -1];
%       tabfile([1,2],4) = [1 -1];
%       tabfile([1,2],5) = 1;
%       csvwrite('dipole_80Hz.csv',tabfile);
    else
%% SCENARIO 2: ("load file" button has been pressed)  
    if strcmp(get(handles.pushbutton8,'Enable'),'off')
        [filename,path] = uigetfile('*.csv','choose parameter table file');
        if filename == 0
            set(handles.pushbutton8,'Enable','on')
            return
        else
        idx = strfind(filename,'_');
        freq0 = str2num(filename(idx+1:end-6));
        set(handles.pushbutton8,'String',filename)
        end
    else
%% SCENARIO 3: (one of the checkboxes in the 'load preset' section has been checked) 
        filename = ['param_',num2str(freq0),'Hz.csv'];
        path = '';
    end
    %% read initial values for sources:
    tabfile = csvread([path,filename]);
end
%gives a (nSources x 11) matrix,
%columns correspond to the following source parameters:
%X,Y,Z,q1,D1,q2,D2,nx,ny,nz,a
%where (X/Y/Z): position,
%     q1,D1: source strength and position according to PS-Model
%     q2,D2: source strength and position according to WG-Model
%     nx,ny,nz: vector indicating the tone holes bore axis
%     a: tone hole diameter
if strcmp(model,'PS')
    tabfile = tabfile(:,[1:3,4,5]);% PS-Model
elseif strcmp(model,'WG')
    tabfile = tabfile(:,[1:3,6,7]);% WG-Model
elseif strcmp(model,'CA')
    tabfile = tabfile(:,[1:3,6,7]);% WG-Model
end

tab = tabfile';

handles.UserData  = tab;
handles.UserData0 = tab*2;

%cache parameters
%guidata(hObject, handles);

%% pass values to GUI (edit and sliders)
%this is very bulky, graceless code. Created manually by use of matlabs GUIDE
%todo: write a function to automatically initializes one set of edits and
%sliders per source id in the GUI

%source 1
sid = 1; %Source ID
set(handles.edit1,'String',tab(1,sid));%edit x
set(handles.edit2,'String',tab(2,sid));%edit y
set(handles.edit3,'String',tab(3,sid));%edit z

set(handles.slider1,'Value',0.5);%slider Q
set(handles.slider2,'Value',0.5);%slider D

set(handles.text26,'String',num2str(round(tab(4,sid)*100)/100));%value Q (from preset)
set(handles.text28,'String',num2str(round(tab(5,sid)*100)/100));%value D (from preset)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 2;
set(handles.edit4,'String',tab(1,sid));
set(handles.edit5,'String',tab(2,sid));
set(handles.edit6,'String',tab(3,sid));

set(handles.text27,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text29,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider3,'Value',0.5);
set(handles.slider4,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 3;
set(handles.edit7,'String',tab(1,sid));
set(handles.edit8,'String',tab(2,sid));
set(handles.edit9,'String',tab(3,sid));

set(handles.text77,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text78,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider5,'Value',0.5);
set(handles.slider6,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 4;
set(handles.edit10,'String',tab(1,sid));
set(handles.edit11,'String',tab(2,sid));
set(handles.edit12,'String',tab(3,sid));

set(handles.text79,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text80,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider7,'Value',0.5);
set(handles.slider8,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 5;
set(handles.edit13,'String',tab(1,sid));
set(handles.edit14,'String',tab(2,sid));
set(handles.edit15,'String',tab(3,sid));

set(handles.text81,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text82,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider9,'Value',0.5);
set(handles.slider10,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 6;
set(handles.edit16,'String',tab(1,sid));
set(handles.edit17,'String',tab(2,sid));
set(handles.edit18,'String',tab(3,sid));

set(handles.text83,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text84,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider11,'Value',0.5);
set(handles.slider12,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 7;
set(handles.edit19,'String',tab(1,sid));
set(handles.edit20,'String',tab(2,sid));
set(handles.edit21,'String',tab(3,sid));

set(handles.text85,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text86,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider13,'Value',0.5);
set(handles.slider14,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 8;
set(handles.edit22,'String',tab(1,sid));
set(handles.edit23,'String',tab(2,sid));
set(handles.edit24,'String',tab(3,sid));

set(handles.text87,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text88,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider15,'Value',0.5);
set(handles.slider16,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 9;
set(handles.edit25,'String',tab(1,sid));
set(handles.edit26,'String',tab(2,sid));
set(handles.edit27,'String',tab(3,sid));

set(handles.text89,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text90,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider17,'Value',0.5);
set(handles.slider18,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 10;
set(handles.edit28,'String',tab(1,sid));
set(handles.edit29,'String',tab(2,sid));
set(handles.edit30,'String',tab(3,sid));

set(handles.text91,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text92,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider19,'Value',0.5);
set(handles.slider20,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 11;
set(handles.edit31,'String',tab(1,sid));
set(handles.edit32,'String',tab(2,sid));
set(handles.edit33,'String',tab(3,sid));

set(handles.text93,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text94,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider21,'Value',0.5);
set(handles.slider22,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 12;
set(handles.edit34,'String',tab(1,sid));
set(handles.edit35,'String',tab(2,sid));
set(handles.edit36,'String',tab(3,sid));

set(handles.text95,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text96,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider23,'Value',0.5);
set(handles.slider24,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 13;
set(handles.edit37,'String',tab(1,sid));
set(handles.edit38,'String',tab(2,sid));
set(handles.edit39,'String',tab(3,sid));

set(handles.text97,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text98,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider25,'Value',0.5);
set(handles.slider26,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sid = 14;
set(handles.edit40,'String',tab(1,sid));
set(handles.edit41,'String',tab(2,sid));
set(handles.edit42,'String',tab(3,sid));

set(handles.text99,'String',num2str(round(tab(4,sid)*100)/100));
set(handles.text100,'String',num2str(round(tab(5,sid)*100)/100));

set(handles.slider27,'Value',0.5);
set(handles.slider28,'Value',0.5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% set frequency slider
set(handles.slider100,'Value',(log10(freq0)-log10(50))/(log10(20000)-log10(50)) );
%set(handles.slider110,'Min',-90,'Max',90,'Value',37.5);
%set(handles.slider120,'Min',-180,'Max',180,'Value',-30);

guidata(hObject,handles);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF GUI CONTROLS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MODELING SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SUBFUNCTION
function [THETA,PHI,P] = modelling(angleStep,tab,freq,flag)
%% plot directivity from point source model
% script for simulation of a multi-pole source
% based upon elementary sources using PointSourceClass
% for omnidirectional or dipol sources, more to come
% oscillator is placed in origin of cartesian system (x=y=z=0)
% obj = PointSourceClass(Q,f,D,Z,Y,X)
% Z,Y,X: position of toneholes/openings (default: 0m)
% version 1.5, 25.12.2019, Malte Kob
%completely revised plot script with Jithin Thilakan and Walter Buchholtzer
%Timo Grothe, ETI, 05.02.2021
%modified to work with manipulate.m- GUI
%Timo Grothe, ETI, 07.03.2022
%modified for 3D output (balloon plots)
%Timo Grothe, ETI, 24.06.2022 / 12.07.2022
%% input
% angleStep  : resolution of the euqiangular sampling grid in degrees
% tab        : parameters (a table with parameters of the source) [x;y;z;Q;D]
% freq       : the frequency to be computed [Hz]
% flag       : set a flag to use the CA-model (cardioid filter)
%% output
% THETA, PHI : matrices with sampling points in azimuthal and elevation
% P          : complex pressure at the sampling points

% uses
%classes:
%PointSourceClass.m            %by Malte Kob
%PointSourceClassD.m           %by Malte Kob and Jithin Thilakan
%
if nargin == 3
    flag = 0;
end


%% INPUT DATA HANDLING
X  = tab(1,:);%x-distance of tonehole in m
Y  = tab(2,:);%y-distance of tonehole in m
Z  = tab(3,:);%z-distance of tonehole in m
Q  = tab(4,:);% amplitude of oscillator
D  = tab(5,:);% acoustic waveguide distance from reed to tonehole

n = size(tab,2); %number of sources

if flag~=1
    %% PS, WG Model
    %initialize point sources
    for i = 1:n
        source(i) = PointSourceClass(Q(i), freq, D(i), Z(i), Y(i), X(i)); % source at at tonehole,
        % parameters: "amplitude", frequency, "acoust. distance", z-position, % y-position, x-position
    end
    
elseif flag
    %% CA Model 
    % CAREFUL: this is under development and not fully supported yet.
    %up till now, we have only one directive soundsource (the bassoons far
    %end, "bell"). Therefore we pass the parameters here manually.
    nx = 0;    %source vector x-component
    ny = 1;    %source vector y-component
    nz = 0;    %source vector y-component
    a  = 0.019;%source opening radius [m]
    
    %% source 1 is a directive source
    for i = 1
        dirsource(i) = PointSourceClassD(Q(i), freq, D(i), Z(i), Y(i), X(i),...
            nx(i), ny(i), nz(i), a(i)); % source at at tonehole,
        % parameters: "amplitude", frequency, "acoust. distance", z-position, y-position, x-position,
        %                   source vector x-component, source vector y-component, source vector z-component, source opening radius
    end
    %% all other sources are point sources
    for i = 2:n
        source(i) = PointSourceClass(Q(i), freq, D(i), Z(i), Y(i), X(i)); % source at at tonehole,
        % parameters: "amplitude", frequency, "acoust. distance", z-position, % y-position, x-position
    end
end

%% sampling points
dist = 2;%[m] radius of the sphere

ns = 180/angleStep-mod(180/angleStep,2) + 1;%force ns to be uneven integer
phi = linspace(-pi/2,pi/2,ns); %elevation
theta = linspace(-2*pi,2*pi,2*(ns-1)+1); %azimuth

[THETA,PHI] = meshgrid(theta,phi);
R = ones(size(THETA))*dist;
[Xi,Yi,Zi] = sph2cart(THETA,PHI,R);


%% PRESSURE FIELD CALCULATION
xi = reshape(Xi,[],1);yi = reshape(Yi,[],1);zi = reshape(Zi,[],1);
pressuresum = 0;

if flag~=1
    %% PS, WG Model%superposition of the sources
    for idx = 1:n
        pressuresum = pressuresum+source(idx).pressure(zi,yi,xi);
    end
    
elseif flag
    %% CA Model
    for idx = 1 %directive source
        pressuresum = pressuresum+dirsource(idx).pressure(zi,yi,xi)';
    end
    for idx = 2:n %pint sources
        pressuresum = pressuresum+source(idx).pressure(zi,yi,xi);
    end
end


% restore original matrix dimensions
P = reshape(pressuresum,size(THETA,1),size(THETA,2));

%
% %% 3D control plot
% dBrange  = 40;
% SPL=reshape(db(abs(P)),size(THETA,1),size(THETA,2));
% maxL = max(max(SPL));
% L = SPL-maxL+dBrange;
% L(L<0) = 0;
% [Xplot,Yplot,Zplot] = sph2cart(THETA,PHI,abs(L));
%
% mesh(Xplot,Yplot,Zplot,'facecolor','none')
% axis equal
% xlabel('x'),ylabel('y'),zlabel('z')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% END OF MODELING SECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%