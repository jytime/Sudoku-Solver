% this file implements the UI control interface

%% parameter preparation
%   call the computer camera
%   please change 'winvideo' to 'macvideo' if you are using MacOS
obj=videoinput('winvideo',1, 'YUY2_1920x1080');
% obj=videoinput('macvideo',1,'YUY2_1920x1080');

% camera setting, trigger properties
set(obj,'TriggerRepeat',inf);
set(obj,'FramesPerTrigger',1);

% call the figure in the UI and set its properties
hf=figure('Units','Normalized','Menubar','None','NumberTitle','off','Name','photoing');
% set the axes for following image processing
ha=axes('Parent',hf,'Units','Normalized','Position',[.05 .2 .85 .7]);
axis off

%% button one, named 'preview'
% this button ensures that customers can preview the captured image
% this buttion is baded on Matlab's inbuilt preview() function
hb1=uicontrol('Parent',hf,'Units','Normalized',...
    'Position',[.20 .05 .2 .1],'String','preview',...
    'Callback',...
    ['objRes=get(obj,''VideoResolution'');'...
    'nBands=get(obj,''NumberOfBands'');'...
    'hImage=image(zeros(objRes(2),objRes(1),nBands));'...
    'preview(obj,hImage);']);

%% button two, named 'photo and solve'
% this button will call the draw_rec() function, which selects the region
% of interest, reads in captured image, ... untill call the sudoku solving
% function
hb2=uicontrol('Parent',hf,'Units','Normalized',...
    'Position',[.60 .05 .2 .1],'String','photo and solve',...
    'Callback','draw_rec(obj);');
