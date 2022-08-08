%Timo Grothe, ETI, 13.07.2022
%GUI with guide for the point source modelling software
%v1.0

function varargout = PointSourceGUI_v1_0(varargin)
% POINTSOURCEGUI_V1_0 MATLAB code for PointSourceGUI_v1_0.fig
%      POINTSOURCEGUI_V1_0, by itself, creates a new POINTSOURCEGUI_V1_0 or raises the existing
%      singleton*.
%
%      H = POINTSOURCEGUI_V1_0 returns the handle to a new POINTSOURCEGUI_V1_0 or the handle to
%      the existing singleton*.
%
%      POINTSOURCEGUI_V1_0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINTSOURCEGUI_V1_0.M with the given input arguments.
%
%      POINTSOURCEGUI_V1_0('Property','Value',...) creates a new POINTSOURCEGUI_V1_0 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PointSourceGUI_v1_0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PointSourceGUI_v1_0_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PointSourceGUI_v1_0

% Last Modified by GUIDE v2.5 13-Jul-2022 09:50:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PointSourceGUI_v1_0_OpeningFcn, ...
                   'gui_OutputFcn',  @PointSourceGUI_v1_0_OutputFcn, ...
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


% --- Executes just before PointSourceGUI_v1_0 is made visible.
function PointSourceGUI_v1_0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PointSourceGUI_v1_0 (see VARARGIN)

% Choose default command line output for PointSourceGUI_v1_0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PointSourceGUI_v1_0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global nSources

%% initial values for sources:
% the fluepipe example for the original JASA submission had 2 sources with the following
% parameters:                     %Q  f  D    z   x   y   nx  ny  nz a
%   sourceMouth = PointSourceClass(Q, f, 0, -l/2, 0,  0,  1,  0,  0, 0); % source at mouth,
%   sourceEnd   = PointSourceClass(Q, f, D,  l/2, 0,  0,  0,  0, -1, 0); % source at passive end, 
% where 
Q = 1e-3;% ("source strength")
l = 0.5404; %(length of pipe in m) ;
D = l;% ("acoustical distance");
% z,x,y : cartesian coordinates of the source
% [nx;ny;nz]: normal vector of the source (not used here)

nSources = 2;
tab = zeros(5,nSources); %5 parameters [x;y;z;Q;D]
tab(:,1) = [0;0;-l/2;Q*1000;0];
tab(:,2) = [0;0; l/2;Q*1000;D];

handles.UserData  = tab;
handles.UserData0 = tab*2;
guidata(hObject, handles);


%todo: write a function to automatically initialize the start values of the edit 
sid = 1;
set(handles.edit1,'String',tab(1,sid));
set(handles.edit2,'String',tab(2,sid));
set(handles.edit3,'String',tab(3,sid));

set(handles.slider1,'Value',0.5);
set(handles.slider2,'Value',0.5);

set(handles.text26,'String',num2str(tab(4,sid)));
set(handles.text28,'String',num2str(tab(5,sid)));

sid = 2;
set(handles.edit4,'String',tab(1,sid));
set(handles.edit5,'String',tab(2,sid));
set(handles.edit6,'String',tab(3,sid));

set(handles.text27,'String',num2str(tab(4,sid)));
set(handles.text29,'String',num2str(tab(5,sid)));

set(handles.slider3,'Value',0.5);
set(handles.slider4,'Value',0.5);

%%
freq0 = 400;%[Hz]
set(handles.slider10,'Value',(log10(freq0)-log10(50))/(log10(20000)-log10(50)) );
set(handles.slider11,'Min',-90,'Max',90,'Value',37.5);
set(handles.slider12,'Min',-180,'Max',180,'Value',-30);


updateGraph(handles)


% --- Outputs from this function are returned to the command line.
function varargout = PointSourceGUI_v1_0_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function updateParameterTableExcitation(hObject,handles)
% to be used with SLIDER

tab0 = handles.UserData0;

%from the object tag
s = get(hObject,'tag');
%read the id of the object
sliderId = str2num(s(7));%disp(sliderId)
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

updateGraph(handles)

function updateParameterTablePosition(hObject,handles)
% to be used with EDIT

%from the object tag
s = get(hObject,'tag');
%read the id of the object
editId = str2num(s(5));%disp(editId)
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


function updateGraph(handles)
%% produces a balloon plot of Levels [dB] on an equiangular spherical grid 
%% with angleStep resolution

%resolution of the grid 
angleStep = str2num(handles.edit13.String);

%source parameters required for PointSourceClass.m
tab = handles.UserData;
% X  = tab(1,:);%x-distance of tonehole in m
% Y  = tab(2,:);%y-distance of tonehole in m
% Z  = tab(3,:);%z-distance of tonehole in m
% Q  = tab(4,:);% "amplitude of oscillator"
% D  = tab(5,:);% "acoustic waveguide distance from reed to tonehole"

%frequency [Hz] (log scaled slider)
scfreq = get(handles.slider10,'Value'); 
freq = 10^((log10(20000)-log10(50))*scfreq + log10(50));
%give the frequency information back to user as text
set(handles.text20,'string',[num2str(round(freq)),' Hz'])

%apply to model
[THETA,PHI,P] = modelling(angleStep,tab,freq);

%% 3D ballon plot
colormap(parula)

%dynamics of the plot
dBrange = str2num(handles.edit14.String);

az = get(handles.slider12,'Value');
el = get(handles.slider11,'Value');


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


%% this is the frequency slider
function slider10_Callback(hObject, eventdata, handles)
updateGraph(handles)

function slider10_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% these are the graph rotation sliders
function slider11_Callback(hObject, eventdata, handles)
updateGraph(handles)

function slider11_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider12_Callback(hObject, eventdata, handles)
updateGraph(handles)

function slider12_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%% the angle resolution edit
function edit13_Callback(hObject, eventdata, handles)
updateGraph(handles)

function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit14_Callback(hObject, eventdata, handles)
updateGraph(handles)

function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% SUBFUNCTIONS AND CLASSES
function [THETA,PHI,P] = modelling(angleStep,tab,freq)
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
%% output
% THETA, PHI : matrices with sampling points in azimuthal and elevation 
% P          : complex pressure at the sampling points

% uses
%classes:
%PointSourceClass.m            %by Malte Kob

%% INPUT DATA HANDLING  
X  = tab(1,:);%x-distance of tonehole in m
Y  = tab(2,:);%y-distance of tonehole in m
Z  = tab(3,:);%z-distance of tonehole in m
Q  = tab(4,:);% amplitude of oscillator
D  = tab(5,:);% acoustic waveguide distance from reed to tonehole

n = size(tab,2); %number of sources

%initialize point sources
for i = 1:n
   source(i) = PointSourceClass(Q(i), freq, D(i), Z(i), Y(i), X(i)); % source at at tonehole,
    % parameters: "amplitude", frequency, "acoust. distance", z-position, % y-position, x-position
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

%superposition of the sources
for idx = 1:n
    pressuresum = pressuresum+source(idx).pressure(zi,yi,xi);
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
