function stewa_run_on_folder(input_folder, file_extension, output_folder)

% input_folder, path to folder containing the files
% file_extension, open all files with this file type, default: "csv"
% output_folder, optional if output folder is needed, default: input_folder

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %error handling
  if nargin < 1
    msg = ['Not enough input arguments'];
    error(msg);
    return;
  end

  %error handling
  if ~ischar(input_folder)
    msg = ['Input input_folder must be string'];
    error(msg);
    return;
  end

  %default values
  if nargin < 2
    file_extension = 'csv';
  end

  %error handling
  if ~ischar(file_extension)
    msg = ['Input file_extension must be string'];
    error(msg);
    return;
  end
  
  %default values
  if nargin < 3
    output_folder = input_folder;
  end

  %error handling
  if ~ischar(output_folder)
    msg = ['Input output_folder must be string'];
    error(msg);
    return;
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %get all filenames
  listing = dir([input_folder, '/*.' file_extension]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  for file_index = 1:size(listing, 1)
    
    %get current file name
    file_name = listing(file_index).name;
    file_path = [input_folder, '/' , file_name];
    
    %load data
    data = stewa_csv_loader(file_path, ';', 2);
    
    %plot and safe input data
    fig = figure(42);
    plot(data(:,1), data(:,2))
    pause(1)
    
    stewa_plot_printer( ...
      [output_folder, '/', file_name], fig, 300, 16/9);
    
  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  close(fig)  
    
end