function data = stewa_csv_loader(file_path, delimiter, header_size)

% file_path, path to file
% delimiter, string of chars used as column delimiter, default: ";"
% header_size, lines at the beginning that don't hold data, default: 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %error handling
  if nargin < 1
    msg = ["Not enough input arguments"];
    error(msg);
    return;
  end

  %default value
  if nargin < 2
    delimiter = ';';
  end
  
  %default value
  if nargin < 3
    header_size = 0;
  end
  
  %error handling
  if ~ischar(file_path)
    msg = ["Input file_path must be string"];
    error(msg);
    return;
  end
  
  %error handling
  if ~ischar(delimiter)
    msg = ["Input delimiter must be string"];
    error(msg);
    return;
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %try to open requested file
  opened_file = fopen(file_path);
  
  %error handling
  if ~is_valid_file_id(opened_file)
    msg = ["Couldn't open file: ", file_path];
    error(msg);
    return;
  end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %get data line by line
  %first_line = fgetl(opened_file);
  %first_line = strsplit(first_line, "; ");
  
  %read data from file
  input_data = dlmread(opened_file, delimiter);
  fclose(opened_file);
  
  %trim to useful rows
  data = input_data(1 + header_size : size(input_data, 1), :);
  
end