
%This script is done to generate publishable images in matlab
%The main output is a matlab fig file called general_figure with the desired image and an image
%without the scale located in the file Data\Resuts\ named image.png

%Due to matlab lousy manipulation of images, is easy to use the fig utility
%in mtlab to save the figure file>>Save>> and select the desired format.

%This script reads the given JP2 images and crops them.
%The user selects the upper left and lower right corners in the original
%image.

%in the file get_parameter.m you have to et up paraameters like the
%projected scale, the desired size of the scale bar nad how much
%compression do you want in the extracted image
clear
close all

image = 'Data\ESP_018854_1755_RED_C_01_ORTHO.JP2'; %put the path to your image

reduction_scale = get_parameters('reduction_scale');
orig_scale = get_parameters('map_projected_scale');
%now we load the one before the slump
%now we load the one before the slump
img = imread(image, 'ReductionLevel', reduction_scale);
%now we choose the points
points = readPoints(img, 2);
cropped_image = img(points(2,1):points(2,2),points(1,1):points(1,2),:);


%First we save the files for analysis, these files have no scale image
folder = 'Data\Results\';
filename = 'image.png';
filename = [folder filename];
imwrite(cropped_image,filename)

%now we generate images with the scale bar at our desired size
scale_bar = get_parameters('scale_bar_size'); % in meters
map_scale = get_parameters('map_projected_scale')*2^get_parameters('reduction_scale'); % in cm/pixel, if it is compressed, it changes
scale_bar_cm = scale_bar*100;
scale_bar_pix = scale_bar_cm/map_scale;
fig = figure;
imshow(cropped_image)
x_offset = 10;
y_offset = 40;
scale_text = num2str(scale_bar)+' m';
rectangle('position', [y_offset, x_offset, scale_bar_pix, 20], 'FaceColor', 'k', 'EdgeColor', 'w')
text(scale_bar_pix/2+x_offset, y_offset+10, '50 m', 'FontSize', 12, 'FontWeight', 'Bold', 'BackgroundColor', 'w')
set(gca,'position',[0 0 1 1],'units','pixels')
savefig('general_figure')

