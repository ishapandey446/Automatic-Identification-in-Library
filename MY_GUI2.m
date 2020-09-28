function varargout = MY_GUI2(varargin)
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

% Last Modified by GUIDE v2.5 03-Mar-2020 17:20:36

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
% VidObj= videoinput('winvideo',2,'RGB24_1280x720');
% handles.VidObj=VidObj;CAM=2;

VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
Image=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(Image,file_name,'jpg');
imshow(Image);

% % Find and Highlight Text in an Image
businessCard = imread('Image.jpg');
ocrResults = ocr(businessCard);
recognizedText = ocrResults.Text;
     figure;
     imshow(businessCard);
     text(800, 150, recognizedText, 'BackgroundColor', [1 1 1]);

Find Text Using Regular Expressions
  businessCard = imread('Image.jpg');
     ocrResults   = ocr(businessCard);
     bboxes = locateText(ocrResults, 'EE','UseRegexp', true);
     img    = insertShape(businessCard, 'FilledRectangle', bboxes);
     figure; imshow(img);

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
BookType={'EE','NAS','DSP','COMP'};
set(handles.popupenu1,'String',BookType);
if(content == get(hObject,'EE'))
    VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
Image=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(Image,file_name,'jpg');  
    businessCard = imread('Image.jpg');
     ocrResults   = ocr(businessCard);
     bboxes = locateText(ocrResults, 'EE','UseRegexp', true);
     img    = insertShape(businessCard, 'FilledRectangle', bboxes);
     figure; imshow(img);
     
     
 else if(content== get(hObject,'NAS'))
         VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
Image=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(Image,file_name,'jpg');
         businessCard = imread('Image.jpg');
     ocrResults   = ocr(businessCard);
     bboxes = locateText(ocrResults, 'NAS','UseRegexp', true);
     img    = insertShape(businessCard, 'FilledRectangle', bboxes);
     figure; imshow(img);
     
     else if(content ==get(hObject,'DSP'))
             VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
Image=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(Image,file_name,'jpg');
       businessCard = imread('Image.jpg');
     ocrResults   = ocr(businessCard);
     bboxes = locateText(ocrResults, 'DSP','UseRegexp', true);
     img    = insertShape(businessCard, 'FilledRectangle', bboxes);
     figure; imshow(img);
     
         else if(content ==get(hObject,'COMP'))
                 VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
Image=getsnapshot(handles.VidObj);
file_name=sprintf('Image.jpg');
imwrite(Image,file_name,'jpg');
                  
                 businessCard = imread('Image.jpg');
     ocrResults   = ocr(businessCard);
     bboxes = locateText(ocrResults, 'COMP','UseRegexp', true);
     img    = insertShape(businessCard, 'FilledRectangle', bboxes);
     figure; imshow(img);
     
                  
             else
                 return 0
 
                 
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_SelectbookFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
get(handles.popupmenu1,'Value')
content = get(handles.popupmenu1,'Value') 
set(handles.text1,'String',BookType{content})

%content = get(handles.popupmenu1, 'string')

% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
end
