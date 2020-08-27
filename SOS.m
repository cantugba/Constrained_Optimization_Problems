% ----------------------------------------------------------------------- %
% Symbiotic Organisms Search(SOS) for unconstrained benchmark problems
% a simplified version, last revised: 2014.08.27
% ----------------------------------------------------------------------- %
% Files of the Matlab code used in the artile:
%
% Min-Yuan Cheng, Doddy Prayogo,         
% Symbiotic Organisms Search: A new metaheuristic optimization algorithm, 
% Computers & Structures 139 (2014), 98-112   
% http://dx.doi.org/10.1016/j.compstruc.2014.03.007                          
%                                                          
% ----------------------------------------------------------------------- %
% Written by Doddy Prayogo at National Taiwan University of Science and 
% Technology (NTUST)
% Email: doddyprayogo@ymail.com
% ----------------------------------------------------------------------- %

%% --- MAIN OPTIMIZER ---
function [bestOrganism bestFitness]=SOS(ecosize,funnum)
tic;
% Outputs: best organism/solution and best fitness
% Inputs: ecosystem/population size and # of benchmark problems 
% Example: [A,B]=SOS (50,17), SOS will solve Sphere (F17) with 50 organisms
% (please see the "OBJECTIVE FUNCTIONS" and "SETUP" sub-functions)
%format compact
fprintf('-------------------------------------------------------------------------\n');
fprintf('  Symbiotic Organisms Search(SOS) for unconstrained benchmark problems\n');
fprintf('-------------------------------------------------------------------------\n\n');

% --- Counters, Parameters & Matrix Initialization
[globalMin lb ub n maxFE]=terminate(funnum);
fprintf(' Ecosystem Size: %d\t\tMaxFE: %d\t\tFunctionNumber: %d',ecosize,maxFE,funnum);
fprintf('\n\n');
fprintf('-------------------------------------------------------------------------\n\n');

FE=0;                           % Function of Evaluation Counter
eco=zeros(ecosize,n);           % Ecosystem Matrix
fitness =zeros(ecosize,1);      % Fitness Matrix

% --- Ecosystem Initialization
for i=1:ecosize
    % Initialize the organisms randomly in the ecosystem 
    eco(i,:)=rand(1,n).*(ub-lb)+lb;
    % Evaluate the fitness of the new solution
    fitness(i,:)=fobj(eco(i,:),funnum); 
    % Increase the number of function evaluation counter
    %FE=FE+1; 
end

% --- Main Looping
while FE<maxFE 
    
    for i=1:ecosize % Organisms' Looping
        
        % Update the best Organism
        [bestFitness,idx]=min(fitness); bestOrganism=eco(idx,:);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Mutualism Phase
            % Choose organism j randomly other than organism i           
            j=i;
            while i==j
                seed=randperm(ecosize); 
                j=seed(1);                  
            end
            
            % Determine Mutual Vector & Beneficial Factor
            mutualVector=mean([eco(i,:);eco(j,:)]);
            BF1=round(1+rand); BF2=round(1+rand);
            
            % Calculate new solution after Mutualism Phase
            ecoNew1=eco(i,:)+rand(1,n).*(bestOrganism-BF1.*mutualVector); 
            ecoNew2=eco(j,:)+rand(1,n).*(bestOrganism-BF2.*mutualVector);
            ecoNew1=bound(ecoNew1,ub,lb); 
            ecoNew2=bound(ecoNew2,ub,lb);
                
            % Evaluate the fitness of the new solution
            fitnessNew1=fobj(ecoNew1,funnum);
            fitnessNew2=fobj(ecoNew2,funnum);
            
            % Accept the new solution if the fitness is better
            if fitnessNew1<fitness(i)
                fitness(i)=fitnessNew1;
                eco(i,:)=ecoNew1;
            end
            if fitnessNew2<fitness(j)
               fitness(j)=fitnessNew2;
               eco(j,:)=ecoNew2;
            end
            
            % Increase the number of function evaluation counter
            FE=FE+2;
            
        % End of Mutualism Phase 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
        % Commensialism Phase
            
            % Choose organism j randomly other than organism i
            j=i;
            while i==j
                seed=randperm(ecosize); 
                j=seed(1);                  
            end
            
            % Calculate new solution after Commensalism Phase    
            ecoNew1=eco(i,:)+(rand(1,n)*2-1).*(bestOrganism-eco(j,:));
            ecoNew1=bound(ecoNew1,ub,lb);

            % Evaluate the fitness of the new solution
            fitnessNew1=fobj(ecoNew1,funnum);

            % Accept the new solution if the fitness is better
            if fitnessNew1<fitness(i)
                fitness(i)=fitnessNew1;
                eco(i,:)=ecoNew1;
            end
            
            % Increase the number of function evaluation counter
            FE=FE+1;
            
        % End of Commensalism Phase
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Parasitism Phase

            % Choose organism j randomly other than organism i 
            j=i;
            while i==j
                seed=randperm(ecosize);
                j=seed(1);
            end
            
            % Determine Parasite Vector & Calculate the fitness
            parasiteVector=eco(i,:);
            seed=randperm(n);           
            pick=seed(1:ceil(rand*n));  % select random dimension
            parasiteVector(:,pick)=rand(1,length(pick)).*(ub(pick)-lb(pick))+lb(pick);
            fitnessParasite=fobj(parasiteVector,funnum);
        
            % Kill organism j and replace it with the parasite 
            % if the fitness is lower than the parasite
            if fitnessParasite < fitness(j)
                fitness(j)=fitnessParasite;
                eco(j,:)=parasiteVector;
            end
            
            % Increase the number of function evaluation counter
            FE=FE+1;
        
        % End of Parasitism Phase
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
    end % End of Organisms' Looping
    
    % Checking the termination criteria
    if bestFitness<globalMin
        break
    end
   
end % End of Main Looping

% --- Update the best Organism
[bestFitness,idx]=min(fitness); bestOrganism=eco(idx,:);

% --- Display the result
%disp(['Funnum: ', num2str(funnum)])
disp(['Best Fitness: ', num2str(bestFitness)])
disp(['Best Organism: ', num2str(bestOrganism)])
toc;


%% --- Boundary Handling --- 
function a=bound(a,ub,lb)
a(a>ub)=ub(a>ub); a(a<lb)=lb(a<lb);

end
