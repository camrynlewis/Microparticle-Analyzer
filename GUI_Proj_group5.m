function varargout = GUI_Proj_group5(varargin)
% GUI_PROJ_GROUP5 MATLAB code for GUI_Proj_group5.fig
%      GUI_PROJ_GROUP5, by itself, creates a new GUI_PROJ_GROUP5 or raises the existing
%      singleton*.
%
%      H = GUI_PROJ_GROUP5 returns the handle to a new GUI_PROJ_GROUP5 or the handle to
%      the existing singleton*.
%
%      GUI_PROJ_GROUP5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PROJ_GROUP5.M with the given input arguments.
%
%      GUI_PROJ_GROUP5('Property','Value',...) creates a new GUI_PROJ_GROUP5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Proj_group5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Proj_group5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Proj_group5

% Last Modified by GUIDE v2.5 18-Nov-2019 22:06:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Proj_group5_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Proj_group5_OutputFcn, ...
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


% --- Executes just before GUI_Proj_group5 is made visible.
function GUI_Proj_group5_OpeningFcn(hObject, eventdata, handles, varargin)
% 1

A = imread('1.png');
axes(handles.axes1);
handles.Image_1 = imshow(A);


% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Proj_group5 (see VARARGIN)

% Choose default command line output for GUI_Proj_group5
handles.output = hObject;

% Update handles structured
guidata(hObject, handles);

% UIWAIT makes GUI_Proj_group5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Proj_group5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton_Orig.
function pushbutton_Orig_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Orig (see GCBO)
I = imread('1.png');
axes(handles.axes1);
imshow(I);


% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_Thresh.
function pushbutton_Thresh_Callback(hObject, eventdata, handles)
file_name = '1.png';
    edit_im = imread(file_name);
   %edit out scale bar for early image analysis
    crop = edit_im(1:899,:,:);
 
    [h,w,p] = size(crop);
    binary = false(h,w);
     for row = 1:1:h
        for col = 1:1:w
               %All rgb values equaled each other when analyzes in image
               %editor e.g. r=35, b=35, g = 35
               red = crop(row,col,1);
               if red > 0 && red < 90
                    binary(row,col) = 1;
               end 
        end 
     end
 
   axes(handles.axes1);
   imshow(binary);
   
   

% hObject    handle to pushbutton_Thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_hist.
function pushbutton_hist_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_name = '1.png';
    edit_im = imread(file_name);
   %edit out scale bar for early image analysis
    crop = edit_im(1:899,:,:);



    [h,w,p] = size(crop);
    binary = false(h,w);
     for row = 1:1:h
        for col = 1:1:w
               %All rgb values equaled each other when analyzes in image
               %editor e.g. r=35, b=35, g = 35
               red = crop(row,col,1);
               if red > 0 && red < 90
                    binary(row,col) = 1;
               end 
        end 
     end
   
    
    %Creating labeling matrix based on binary and counting how many objects
    %there are
    
    %Fill in each object
    binary = imfill(binary,'holes');
   
    
    
    % Create matrix labeling each object
     [label, counter] = bwlabel(binary,4);
     
     measurements = regionprops(label,'EquivDiameter');
     diameters = [measurements.EquivDiameter];
%Used imtool to find pixel length of the scale bar: 519.06 pix = 200 um

%Calibration factor calculation

calibrate = 200/519.06;
distance_in_um = diameters*calibrate;
fprintf('There are this many objects in the image before filtering: %d\n',counter)

%Filtering out all of the diameter values less than 11 micrometers 
ii = 1;
while ii <= counter(end)
    if distance_in_um(ii) < 11
       distance_in_um(ii) = [];
       counter = counter - 1;
       ii = ii-1;
    end
    ii = ii+1;
end
fprintf('There are this many objects in the image after filtering: %d\n',counter)


avg_dia = mean(distance_in_um);
fprintf('Average Diameter: %d\n',avg_dia)
% Histogram showing the distribution of diameters of the current image

histogram(distance_in_um)
xlabel('Diameter in um')
ylabel( '# of microparticles')
title('Distribution of Microparticle Diameters')
