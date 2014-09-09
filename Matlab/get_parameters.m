function param = get_parameters(value)

switch value
    case 'reduction_scale'
        param = 0; %Thi is 2^X reduction, so beware
    case 'map_projected_scale'
        param = 25; %This is given in cm/pixel
    case 'scale_bar_size' %size of the scale bar in meters
        param = 50;
    otherwise
        disp('I did not find that parameter')
end
