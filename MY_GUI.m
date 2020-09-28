function varargout = MY_GUI(varargin)
% MY_GUI MATLAB code for MY_GUI.fig
%      MY_GUI, by itself, creates a new MY_GUI or raises the existing
%      singleton*.
%
%      H = MY_GUI returns the handle to a new MY_GUI or the handle to
%      the existing singleton*.
%
%      MY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_GUI.M with the given input arguments.
%
%      MY_GUI('Property','Value',...) creates a new MY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MY_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MY_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MY_GUI

% Last Modified by GUIDE v2.5 23-Feb-2020 22:25:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MY_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MY_GUI_OutputFcn, ...
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


% --- Executes just before MY_GUI is made visible.
function MY_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MY_GUI (see VARARGIN)

% Choose default command line output for MY_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MY_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MY_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Capture.
function Capture_Callback(hObject, eventdata, handles)
% hObject    handle to Capture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
VidObj= videoinput('winvideo',1,'YUY2_640x480');
handles.VidObj=VidObj;CAM=1;
S=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(S,file_name,'jpg');
imshow(S);


warning off %#ok<WNOFF>
% Clear all
% Read image
imagen=imread('Image.jpg');
% Show image
imshow(imagen);
title('INPUT IMAGE WITH NOISE')
% Convert to gray scale
if size(imagen,3)==3 %RGB image
    imagen=rgb2gray(imagen);
end
% Convert to BW
threshold = graythresh(imagen);
imagen =~im2bw(imagen,threshold);
% Remove all object containing fewer than 30 pixels
imagen = bwareaopen(imagen,30);
%Storage matrix word from image
word=[ ];
re=imagen;
%Opens text.txt as file for write
fid = fopen('text.txt', 'wt');
% Load templates
load templates
global templates
% Compute the number of letters in template file
num_letras=size(templates,2);
while 1
    %Fcn 'lines' separate lines in text
    [fl re]=lines(re);
    imgn=fl;
    %Uncomment line below to see lines one by one
    %imshow(fl);pause(0.5)    
    %-----------------------------------------------------------------     
    % Label and count connected components
    [L Ne] = bwlabel(imgn);    
    for n=1:Ne
        [r,c] = find(L==n);
        % Extract letter
        n1=imgn(min(r):max(r),min(c):max(c));  
        % Resize letter (same size of template)
        img_r=imresize(n1,[42 24]);
        %Uncomment line below to see letters one by one
         %imshow(img_r);pause(0.5)
        %-------------------------------------------------------------------
        % Call fcn to convert image to text
        letter=read_letter(img_r,num_letras);
        % Letter concatenation
        word=[word letter];
    end
    %fprintf(fid,'%s\n',lower(word));%Write 'word' in text file (lower)
    fprintf(fid,'%s\n',word);%Write 'word' in text file (upper)
    % Clear 'word' variable
    word=[ ];
    %*When the sentences finish, breaks the loop
    if isempty(re)  %See variable 're' in Fcn 'lines'
        break
    end    
end
fclose(fid);
%Open 'text.txt' file
winopen('text.txt')
fprintf('For more information, visit: <a href= "http://www.matpic.com">www.matpic.com </a> \n')
clear all





     
     
