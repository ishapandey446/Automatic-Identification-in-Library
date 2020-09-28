
clc
clear all
% cam=videoinput('winvideo',1,'YUY2_640x480');
% my_image=getsnapshot(cam);
% file_name=sprintf('Image.jpg');
% imwrite(my_image,file_name,'jpg');

VidObj= videoinput('winvideo',1,'MJPG_1280x720');
handles.VidObj=VidObj;CAM=1;
S=getsnapshot(handles.VidObj);
    closepreview
%     clear VidObj
%     delete  VidObj
     imshow(S);