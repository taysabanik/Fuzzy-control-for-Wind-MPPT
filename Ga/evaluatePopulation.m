function [fitness, cont_simu] = evaluatePopulation(parameters,population)

   cont_simu = 0;
   fitness = zeros(size(population,1),1);

   for j=1:size(population,1)
           warning('off','all')


       %Penalizações com base nas restrições --------------------------------------------------------
    
        if (any(population(j,1:2) > parameters.Restr(2)) || any(population(j,1:2) < parameters.Restr(1))); fitness(j,1) = 1000; continue; end
        if (any(population(j,3) > parameters.Restr(4)) || any(population(j,3) < parameters.Restr(3))); fitness(j,1) = 1000; continue; end
        if (any(population(j,4) > parameters.Restr(6)) || any(population(j,4) < parameters.Restr(5))); fitness(j,1) = 1000; continue; end
        if (any(population(j,5) > parameters.Restr(8)) || any(population(j,5) < parameters.Restr(7))); fitness(j,1) = 1000; continue; end
        if (any(population(j,6) > parameters.Restr(10)) || any(population(j,6) < parameters.Restr(9))); fitness(j,1) = 1000; continue; end
        
        try
            fis = newFis(population(j,:));
           
            ke = population(j,1);
            kde = population(j,2);
            aux = load('C:\Users\LICON\Documents\MATLAB\PMSG\defesa\Otim\NewFis\StepRef\saidasPItensao.mat');
            current= aux.out.Iind;
            y = aux.out.tempo;
            
            try
%Estabelece os inputs da simulação
                simIn = Simulink.SimulationInput('pmsg_wind_turbine_simpfuzzyCURRENT');
                simIn = simIn.setVariable('ke',ke);
                simIn = simIn.setVariable('kde',kde);
                simIn = simIn.setVariable('fis',fis);
                simIn = simIn.setVariable('current',current);
                simIn = simIn.setVariable('y',y);

% Executa a simulação e captura o output --------------------------------------------------------
                simOut = sim(simIn);
                clc

                try
% Acessa os dados salvos pela simulação--------------------------------------------------------

                    error = simOut.get('erro');
                    error = [error.time error.data];
             
                    fitness(j,1) = fitnessmetodo3(error);
                    cont_simu = cont_simu + 1;

                catch ME
% penaliza o erro de CALCULO--------------------------------------------------------
                    %disp(ME)
                    fitness(j,1) = 602;continue;
                end


            catch ME
% penaliza o erro de simulação--------------------------------------------------------
                %disp(ME)
                fitness(j,1) = 601;continue;

            end


        catch ME
% penaliza o erro de criação do Fuzzy--------------------------------------------------------
        %disp(ME)
        fitness(j,1) = 600;continue;

        end


    end

       
end
