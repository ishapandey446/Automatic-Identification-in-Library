     
vid=videoinput('winvideo',2,'MJPG_1280x720');
set(vid,'returnedcolorspace','rgb');
pic1=getsnapshot(vid);
imshow(pic1);

file_name=sprintf('pic1.jpg');
imwrite(pic1,file_name,'jpg');

     businessCard   = imread('pic1.jpg');
     ocrResults     = ocr(businessCard)
     recognizedText = ocrResults.Text;
     figure;
     imshow(businessCard);
     text(800, 150, recognizedText, 'BackgroundColor', [1 1 1]);
     
%           businessCard   = imread('pic1.jpg');
% ocrResults = ocr(businessCard);
% bboxes = locateText(ocrResults, 'B', 'IgnoreCase', true);
% Iocr = insertShape(businessCard, 'FilledRectangle', bboxes);
% figure; imshow(Iocr);