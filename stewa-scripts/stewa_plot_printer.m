function stewa_plot_printer(file_name, figure_handle, dpi, ratio)

% file_name, name of output file without file extension
% figure_handle, handle of figure to to plot, default: use last opened figure
% dpi, png resolution in pots per inch
% ratio, aspect ratio for output, default: 16:9

% Setup on Windows:
% Download https://inkscape.org/gallery/item/10686/Inkscape-0.92.1.7z
%   -> or newer, but use the .7z download
% unzip the contained "inkscape"-folder into the folder containing this file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %error handling
  if nargin < 1
    msg = ["Not enough input arguments"];
    error(msg);
    return;
  end
  
  %error handling
  if ~ischar(file_name)
    msg = "file_name must be a string!";
    error(msg);
    return;
  end
  
  %aspect ratio
  if nargin < 4
    ratio = 16 / 9;
  end
  
  %resolution
  if nargin < 3
    dpi = 90;
  end

  %figure
  if nargin < 2
    figure_handle = gcf;
  end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %check for inkscape
  
  %running on windows?
  if ispc
    if exist('.\inkscape\inkscape.exe') ~= 2
      inkscape_installed = false;
    else
      inkscape_installed = true;
    end
  end

  %running on linux?
  if isunix
    if system("inkscape -V > /dev/null") ~= 0
      inkscape_installed = false;
    else
      inkscape_installed = true;
    end
  end
  
  if inkscape_installed
    disp("inkscape installation found!");
    disp("PNG output enabled!");
    fflush(stdout);
  else
    disp("inkscape installation not found!");
    disp("SVG output enabled!");
    fflush(stdout);
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  %save vector graphic
  resolution = ["-S1200,", num2str(1200 / ratio)];
  print(figure_handle, [file_name, ".svg"], resolution);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %convert to png image
  if inkscape_installed
    
    command_string = ['"inkscape" -f ', file_name, '.svg'];
    command_string = [command_string, ' -C -d ', num2str(dpi) ,' -e ', file_name, '.png'];
    
    %running on windows?
    if ispc()
      command_string = ['".\inkscape\' command_string];
      command_string = [command_string, ' >NUL'];
    end
    
    %running on linux?
    if isunix()
      command_string = [command_string, ' >/dev/null'];
    end
    
    %execute command
    system(command_string);    
    
    %cleanup
    if ispc()
      system(strrep(['del "', file_name, '.svg"'], "/", "\\"));
    end
    
    if isunix()
      system(['rm "', file_name, '.svg"']);
    end
    
  end % of png output
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
end