%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function MapReduce_find_mutual_facebook_friends_example
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find mutual facebook friends using MapReduce algorithm.

%% see
%% help/matlab/import_export/getting-started-with-mapreduce.html#bug4okz
%% Eli, APM120, 201906

%% select data file:
ds = datastore('Data/friends.txt');
% send a single line of the data to the map function each time:
ds.ReadSize=1;

%% display information about entire dataset:
ds
fprintf(1,'specified dataset ReadSize=%d\n',ds.ReadSize);
%% show a few data values:
fprintf(1,'\n\nA preview of some of the flight data values:\n')
preview(ds)
%% calculate mean daily flight delay using MapReduce:
outds = mapreduce(ds, @mutual_friends_MapFun, @mutual_friends_ReduceFun ...
                  ,'OutputFolder','./Output/friends/');

%% read and display results:
a=readall(outds);
N=length(a.Key);
disp('users: mutual friends')
for i=1:N
  fprintf(1,'%s:   ',char(a.Key(i)));
  fprintf('%d,',cell2mat(a.Value(i)));
  fprintf('\n');
end

%% now display number of mutual friends for each user pair
disp('now display number of mutual friends for each user pair')
disp('users: # of mutual friends')
for i=1:N
  fprintf(1,'%s:   ',char(a.Key(i)));
  fprintf('%d,',length(cell2mat(a.Value(i))));
  fprintf('\n');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mutual_friends_MapFun(data, info, intermKVStore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Map function: input is a chunk of the data. Output is the sum
%% over delays and number of delay events per each day, for this
%% chunk only, returned as a (KEY,VALUE) pair. 

fprintf(1,['--> entering map function: ' ...
           'size(data)=%dx%d\n'] ,size(data));
fprintf(1,'info.Offset=%d, info.NumCharactersRead=%d\n' ...
        ,info.Offset,info.NumCharactersRead);

%% Initialize variables 
%% calculate sum over delays and number of delay events, per each
%% day, only for the current chunk of data:
input_data=table2array(data);
user=input_data(1);
friends=input_data(2:end);
Nfriends=length(friends);
for i=1:Nfriends
  for j=1:Nfriends
    friend1=friends(i);
    friend2=friends(j);
    if friend1>friend2
      %% returned KEY is pair of friends;
      %% returned VALUE is the user on this line
      %% add(intermKVStore, KEY, VALUE)
      key=sort([friend1,friend2]);
      key_character=sprintf('%d %d',key);
      add(intermKVStore, key_character, user);
    end
  end
end
fprintf(1,'exiting map function Mean_Daily_Delay_MapFun\n');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function mutual_friends_ReduceFun(intermKey, intermValIter, outKVStore)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Reduce function. Called once for each value of the key.  We
%% have 7 values corresponding to 7 days. Each call to this reduce
%% function therefore deals with flight delay data corresponding to
%% one day.

fprintf(1,'--> entering reduce function, intermKey = %s:\n',intermKey);

%% Loop over all data belonging to the day given by intermKey:
%% This is based on the SHUFFLE STEP, because mapreduce now needs to
%% sort all keys and return here only the ones we are requesting:
num_mutual_friends=0;
while hasnext(intermValIter)
  num_mutual_friends=num_mutual_friends+1;
  next_value=getnext(intermValIter);
  %% calculate the sum over delays and the number of delays:
  mutual_friends(num_mutual_friends) = next_value;
end
%% return output of calculation for each day, again as a (KEY,VALUE)
%% pair, where the key is the day and the value is the mean delay:
add(outKVStore, intermKey, mutual_friends);

fprintf(1,' key=%s; mutual_friends: ',intermKey)
fprintf(1,' %d,',mutual_friends)
fprintf(1,' \n')
fprintf(1,'exiting reduce function Mean_Daily_Delay_ReduceFun.\n');
end
end