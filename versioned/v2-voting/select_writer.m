
function data = select_writer(num)

load('writerdata.mat');

numbers = 1:194;

num = 32;

arrsize = size(numbers,2);
pickednums = [];

data = [];

for i=1:num
    number = round(ceil(rand([1,1])*arrsize));
    pickednums = [pickednums numbers(number)];
    numbers(number) = [];
    arrsize = arrsize-1;
end


for i = 1:size(pickednums,2)
    data = [data dat(pickednums(i))];
end