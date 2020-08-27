addpath('amacFonksiyonu');
addpath('ayarlar');
addpath('kisitlar');
addpath('dsos');

clc
clear

bestValues = zeros(51,1);
for i=1:51
[bestFitness] = fdb_sos();
bestValues(i) = bestFitness;

end
min(bestValues)
max(bestValues)
std(bestValues)
mean(bestValues)
median(bestValues)

%  amacFunction([0.0500041747086985 0.403731962455249 6.8203430053535], 1)
%  amacFunction([0.0500 0.2500 9.9877],1)
%  amacFunction([0.2500 0.0500 9.9877],1)
 