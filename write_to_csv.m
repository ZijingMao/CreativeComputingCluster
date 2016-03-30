load('ClusteringResult.mat');
filename = 'ClusterResult.csv';

% start write string to file
fid = fopen(filename,'w');
headers = cellstr(motivation);
header_string = headers{1};
for i = 2:length(headers)
    header_string = [header_string,',',headers{i}];
end
fprintf(fid,'%s\r\n',header_string);

for i = 1:size(index, 2)
    current_data = cellstr(squeeze(index(:, i, :)));
    current_data_string = current_data{1};
    for j = 2:length(current_data)
        current_data_string = [current_data_string,',',current_data{j}];
    end
    fprintf(fid,'%s\r\n',current_data_string);
end

fclose(fid);