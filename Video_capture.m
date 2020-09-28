function varargout = Video_capture(varargin)
% _____________________________________________________
%Author: Diego Barragán.
% www.matpic.com
% _____________________________________________________
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Video_capture_OpeningFcn, ...
    'gui_OutputFcn',  @Video_capture_OutputFcn, ...
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
% ---
function Video_capture_OpeningFcn(hObject, eventdata, handles, varargin)
%
movegui(hObject,'center')
%
set(handles.parar_b,'UserData',0)
%
set(handles.axes1,'XTick',[ ],'YTick',[ ])
set(handles.axes2,'XTick',[ ],'YTick',[ ])
%
imaqreset
%
% try
% handles.vid = videoinput('winvideo',1,'YUY2_352x288');
% catch %
%     warndlg({'NO SE ENCUENTRA CÁMARA CONECTADA'...
%                     ;'POR FAVOR CONECTE UNA WEBCAM'},'AVISO WEBCAM')
%     return
% end
% %
% handles.vid.FrameGrabInterval = 3;
% %
% handles.vid.TriggerRepeat=Inf;
%

% Choose default command line output for Video_capture
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = Video_capture_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;

% ---
function inicio_b_Callback(hObject, eventdata, handles)
%
set(handles.inicio_b,'Enable','off')
%
set(handles.parar_b,'UserData',0)
%
handles.vidobj.FrameGrabInterval = 3;
%
handles.vidobj.TriggerRepeat=Inf;
start(handles.vidobj);
%
conta=0;
while true
    %
    if get(handles.parar_b,'UserData')
        stop(handles.vidobj);
        break %
    end
    %
    imgn = ycbcr2rgb(getdata(handles.vidobj,1,'uint8'));
    %
    axes(handles.axes1);
    image(imgn);
    axis off   %
    %
    axes(handles.axes2);
    %
    efecto=get(handles.efectos,'Value');
    switch efecto
        case 1 %
            im_proc=rgb2gray(imgn);
            colormap gray
        case 2 %
            im_proc=im2bw(imgn);
            colormap gray
        case 3 %
            im_proc=rgb2hsv(imgn);
        case 4 %
            im_proc=imgn(1:end,end:-1:1,1:3);
        case 5 %
            im_proc=imgn(end:-1:1,1:end,1:3);
        otherwise %
            im_proc=imgn(1:5:end,1:5:end,1:3);
    end
    %
    imagesc(im_proc);
    axis off %
end
%
guidata(hObject, handles);

% ---
function parar_b_Callback(hObject, eventdata, handles)
%
set(handles.parar_b,'UserData',1)
%
set(handles.inicio_b,'Enable','on')

% ---
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% if(strcmp(handles.vid.Running,'on')) %
%     set(handles.parar_b,'UserData',1) %
% else
delete(hObject); %
% end

% --- Executes on selection change in efectos.
function efectos_Callback(hObject, eventdata, handles)


% --- Executes on button press in sel_cam.
function sel_cam_Callback(hObject, eventdata, handles)
% Open GUI to select the camera
sel_camera
% wait until
uiwait
% Bring the camera features
global id es_web_ext
handles.es_web_ext=es_web_ext;
handles.id=id;
if es_web_ext==0
    formato='YUY2_176x144';
else
    formato='RGB24_320x240';
end
try
    % Create video object
    handles.vidobj = videoinput('winvideo',id,formato);
    guidata(hObject, handles);
catch
    msgbox('Check the connection of the camera','Camera')
    set(handles.axes1,'XTick',[ ],'YTick',[ ])
end