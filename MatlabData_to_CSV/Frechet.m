%%read data
files = dir('*.mat');
n = length(files);
t = 20;
frechet_array=cell(n,1);
for i=1:n
    frechet_array{i}=load(files(i).name);
end

%%minimum Frechet
minFrechet = zeros(n*t,4);

for i=1:n
    for j=1:t
        minFrechet((i-1)*20+j,1)= min(frechet_array{i, 1}.fdmix(j,1:4));
        minFrechet((i-1)*20+j,2)= min(frechet_array{i, 1}.fdmix(j,:));
        minFrechet((i-1)*20+j,3)= min(frechet_array{i, 1}.fdmix(j,5:14));
        minFrechet((i-1)*20+j,4)= min(frechet_array{i, 1}.fdmix(j,[1,2,3,4,9,11]));
        
    end
end

T = array2table(minFrechet);
T.Properties.VariableNames(1:4) = {'Pure','All','Mix','Six'};
writetable(T,'minFrechet2.csv');

%%best fit strategies

T = array2table(strategyGoto);
T.Properties.VariableNames(1:20) = {'T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T13','T14','T16','T17','T18','T19','T21','T22','T23','T24'};
writetable(T,'strategyGoto.csv');

T = array2table(strategyShortcut);
T.Properties.VariableNames(1:20) = {'T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T13','T14','T16','T17','T18','T19','T21','T22','T23','T24'};
writetable(T,'strategyShortcut.csv');

%%SV distribution
T = array2table(svGoto.');
writetable(T,'SVGotoGoal.csv');
T = array2table(svShortcut.');
writetable(T,'SVShortcut.csv');

%%Simulation
T = array2table(strat2to1.');
writetable(T,'SimShortcut.csv');
T = array2table(strat16to1.');
writetable(T,'SimGotoGoal.csv');
