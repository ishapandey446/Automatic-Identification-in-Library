% clc
% clear all
% cam=videoinput('winvideo',2,'RGB24_1280x720');
% for i=1:2
%     my_image=getsnapshot(cam);
%     file_name=sprintf('Image%d.jpg',i);
%     imwrite(my_image,file_name,'jpg');
%     pause(1);
% end


% webcamlist
% cam = webcam('Lenovo EasyCamera')
% preview(cam)
% photo=videoinput('winvideo',1);
% for i=1:5
%     my_image=snapshot(photo);
%     file_name=['Image' num2str(i)];
%     imwrite(my_image,file_name,'png');
%     pause(2);
%     imshow(my_images(i));
% end

clc
clear all
cam=videoinput('winvideo',2,'RGB24_1280x720');
my_image=getsnapshot(cam);
file_name=sprintf('Image.jpg');
imwrite(my_image,file_name,'jpg');

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


   

