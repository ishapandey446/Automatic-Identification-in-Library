function varargout = MyUSBShow(varargin)
% MYUSBSHOW MATLAB code for MyUSBShow.fig
%      MYUSBSHOW, by itself, creates a new MYUSBSHOW or raises the existing
%      singleton*.
%
%      H = MYUSBSHOW returns the handle to a new MYUSBSHOW or the handle to
%      the existing singleton*.
%
%      MYUSBSHOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYUSBSHOW.M with the given input arguments.
%
%      MYUSBSHOW('Property','Value',...) creates a new MYUSBSHOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyUSBShow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyUSBShow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyUSBShow

% Last Modified by GUIDE v2.5 13-Sep-2018 20:22:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MyUSBShow_OpeningFcn, ...
    'gui_OutputFcn',  @MyUSBShow_OutputFcn, ...
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


% --- Executes just before MyUSBShow is made visible.
function MyUSBShow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyUSBShow (see VARARGIN)

global cap isstop numFrame
cap = webcam(1);
isstop = false;
numFrame = 1;
% Choose default command line output for MyUSBShow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyUSBShow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyUSBShow_OutputFcn(hObject, eventdata, handles)
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
global cap isstop numFrame
if isstop
    isstop = false;
else
    isstop = true;
end
axes(handles.axes1);
ts1 = 0;
while exist('isstop','var')&&isstop
    numFrame = numFrame+1;
    [frame,ts] = snapshot(cap);
    frameRate = 1./(ts-ts1);
    ts1 = ts;
    
    showText = sprintf('frameRate:%d\n  Frame:%d\n',round(frameRate),numFrame);
    draw = insertText(frame,[10,20],showText,'FontSize',20);
    imshow(draw);
    drawnow;
end

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ¹Ø±Õ´°¿ÚµÄ»Øµ÷º¯Êý
clear all;
