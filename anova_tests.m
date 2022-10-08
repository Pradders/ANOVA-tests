%ANOVA tests
%Conducts an n-way ANOVA analysis. ANOVA (analysis of variance) assesses the variation between means of data groups. In practise, it will check how much an independent variable affects the results.


%Clear workspace and variables
clear;
clc;

%Input data and associated variables here. Make sure that they are in columns (i.e., transpose data if necessary). If the data comes from an external source, then the numbers should be numerical (i.e., not in string form) and the variables should be in string form. An example is provided below.
%yield = [86.8 82.4 86.7 83.5 93.4 85.2 94.8 83.1 77.9 89.6 89.9 83.7 71.9 72.1 80.0 77.4 74.5 87.1 71.9 84.1 87.5 82.7 78.3 90.1 65.5 72.4 76.6 66.7 66.7 77.1 76.7 86.1 72.7 77.8 83.5 78.8 63.9 70.4 77.2 81.2 73.7 81.6 84.2 84.9 79.8 75.7 80.5 72.9]';
%catalyst = ['A' 'A' 'A' 'A' 'A' 'A' 'A' 'A' 'A' 'A' 'A' 'A' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'B' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'C' 'D' 'D' 'D' 'D' 'D' 'D' 'D' 'D' 'D' 'D' 'D' 'D']';
%reagent = ['1' '1' '1' '1' '2' '2' '2' '2' '3' '3' '3' '3' '1' '1' '1' '1' '2' '2' '2' '2' '3' '3' '3' '3' '1' '1' '1' '1' '2' '2' '2' '2' '3' '3' '3' '3' '1' '1' '1' '1' '2' '2' '2' '2' '3' '3' '3' '3']';


%Now using some random data from an external file:
data = load('loadcalc.txt'); %Check if this function works, else use the previous data and adjust the below equations

    loading = data(:,1); %Amount of metal used
    calcination = data(:,2); %Material synthesis temperature
    temperature = data(:,3); %Reaction temperature
    yield = data(:,4); %Product composition


%Generalise the input requirements. Here, there are three independent x variables. Add more key variables as X4, X5, etc. if more are required. This also assumes a 5% confidence interval, but this can be adjusted as well.
Y = yield;
X1 = loading;
X2 = calcination;
X3 = temperature;
alpha = 0.05;


%Allow the user to input the preferred ANOVA test. This could be a one-way, two-way or two-way with data replicates or three-way with replicates, or beyond. Adjust the input statement for four-way or above.
disp('Indicate one of the following: anova1,anova2,anova2r,anova3r');
user = input('Enter the type of ANOVA test preferred: ','s');
lower_user = lower(user);


%Begin the ANOVA test based on the user input. Adjust this as well in case there are more independent variables to compare between.

    %One-way ANOVA (with replicates)
    if strcmp('anova1',lower_user) == true
        [P,TABLE,STATS,TERMS] = anovan(Y,{X1},'alpha',alpha);
        [c,m,h,gnames] = multcompare(STATS);
        disp(c);
    %Two-way ANOVA (no replicates)
    elseif strcmp('anova2',lower_user) == true
        [P,TABLE,STATS,TERMS] = anovan(Y,{X1 X2},'alpha',alpha,'model',1); %'model, 1' specifically represents two-way ANOVA without replicates
        [c,m,h,gnames] = multcompare(STATS);
        disp(c);
    %Two-way ANOVA (replicates)
    elseif strcmp('anova2r',lower_user) == true
        [P,TABLE,STATS,TERMS] = anovan(Y,{X1 X2},'alpha',alpha,'model',2); %'model, 2' specifically represents two-way ANOVA with replicates
        [c,m,h,gnames] = multcompare(STATS);
        disp(c);
	%Three-way ANOVA (replicates)
    elseif strcmp('anova3r',lower_user) == true
        [P,TABLE,STATS,TERMS] = anovan(Y,{X1 X2 X3},'alpha',alpha,'model','interaction');  %'interaction' specifically represents n-way ANOVA with replicates
        [c,m,h,gnames] = multcompare(STATS);
    else
        disp('Try again');
    end


%Data will output the associated Sum of Squares, Degrees of Freedom, Mean of Squares, F-statistic and Probability for each variable.