function t = read_case_data(dataPath, datarecordtype)
% reads in all EDF files at the specified data path in the specified format
%   datarecordtype can have the values 'vector' or 'timetable'

% TODO: preallocate timetable to reduce processing time!
    cd(dataPath);
    all_files = dir( "*.edf" );
    name = {}; data = {}; info = {};
    for i = 1:length(all_files)
        file = all_files(i).name;
        name = [name; {file(1:end-4)}];
        [data{i,1}, annotations{i,1}] = edfread(file, ...
                                                'DataRecordOutputType', datarecordtype, ...
                                                'TimeOutputType','datetime');
        info = [info; {edfinfo(file)}];
    end
    
    t = table(data, annotations, info, 'RowNames', name);
end
