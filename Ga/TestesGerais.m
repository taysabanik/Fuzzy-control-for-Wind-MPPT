clc
clear
tic
% Parameters --------------------------------------------------------

ini_ind = [8 10 0.1 0.5 1 12];

% Parameters --------------------------------------------------------
parameters.populationSize = 20;

parameters.chromosomeLength = 6;

parameters.maxGenerations = 30;

parameters.mutationRate = 0.03;

parameters.crossoverRate = 0.35;

parameters.Restr = [[0 50] [0.1 0.22] [0.25 2] [1 9.58] [9.7 20]];

parameters.tournamentSize = 10;

parameters.criterion = 0;%criterio para maximizar (1) ou para minimizar (0) a função objetivo

parameters.k = 1;%parametro para printar no commandWindow os K's melhores de cada geração

parameters.runsNumber = 10;

parameters.fitnessRef = 0.144986;

% parameters.fitnessRef = 0.5696;% (valor de fitness com média movel e IAE's separadas)
% parameters.fitnessRef = 0.1632; %(valor de fitness com média movel e só IAE. Serve para o metodo 2)
%1.5982(valor de fitness sem média movel)

parameters.countmax = 10;% define o numero de vezes que o fitness de referencia deve ser superado

%Adiciona o caminho dos otimizadores --------------------------------------------------------
addpath('C:\Users\LICON\Documents\MATLAB\PMSG\defesa\Otim\NewFis\StepRef\Ga\')

%Carrega o sistema --------------------------------------------------------
load_system('pmsg_wind_turbine_simpfuzzyCURRENT.slx');
warning('off','all')


% Configura os parâmetros da simulação --------------------------------------------------------
%set_param('buck_pvLucas', 'StopTime', '4','SimulationMode','accelerator')

% Deleta o parallel pool atual sem criar um.
% delete(gcp('nocreate'))
% 
% % %Inicia o pool de trabalhadores paralelos --------------------------------------------------------
% parpool('local',6); 


   
% ini_ind = [0.061115 0.033021 0.004849 1.545426 0.088281 1.000000 0.519446 0.000000 0.755413 -0.194965 -0.344244 0.059074 0.000023 1.000000 0.714699 -0.000000 0.800000 0.016768 -0.403689 0.007033 -0.030155 1.000000 0.916561 -0.000000 0.013311 -0.806952 -0.812818 0.008868 0.403646 1.000000 0.034956 -0.000000 0.129821 -0.385175 -0.981524 0.040807 1.000000 0.034713 1.000000 0.783526 0.274451 0.365143 0.899085 0.909842 0.200597 0.021021 0.963793 0.001794 0.008375 0.011807 1.000000 0.499582 0.319544 1.000000 0.373966 0.033927 0.548770 0.608723 1.000000 1.000000 0.077791 0.145736 0.063752 0.056551 0.228602 0.221454 0.948490 0.717619 1.000000 0.347612 0.194931 1.000000 0.010642 1.000000 0.119419 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000 1.000000];

[fitness, cont_simu] = evaluatePopulation(parameters,ini_ind)

toc