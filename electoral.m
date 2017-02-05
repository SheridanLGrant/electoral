% Sheridan Grant
% 12/24/2016
% Electoral Votes by Race

cd('C:\Users\Sheridan\Desktop\Code\Electoral');

y2000 = xlsread('2000.xls');
[num, txt, raw] = xlsread('2000.xls', 'A11:L478');
y2k = readtable('2000.xls',...
    'Range', 'A11:L478',...4
    'ReadVariableNames', false);
y2k = y2k(:, [1, 11, 12]);

