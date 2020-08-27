function [bestFitness] = sos()

rand('state', sum(100*clock));
[ecosize, n, maxFE, lb, ub] = problem_terminate();

FE=0;                           % Function of Evaluation Counter
eco=zeros(ecosize,n);           % Ecosystem Matrix
fitness=zeros(1, ecosize);
% --- Ecosystem Initialization
for i=1:ecosize
    eco(i,:)=rand(1,n).*(ub-lb)+lb;
    fitness(i) = problem(eco(i,:));
end

% --- Main Looping
while FE<maxFE 
    
    for i=1:ecosize % Organisms' Looping
        
        % Update the best Organism
        [~, idx]=min(fitness); bestOrganism=eco(idx,:);
        
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
                
            fitnessNew1 = problem(ecoNew1);
            fitnessNew2 = problem(ecoNew2);
            
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

            fitnessNew1 = problem(ecoNew1);

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

            fitnessParasite = problem(parasiteVector);

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
    
   
end % End of Main Looping

% --- Update the best Organism
[bestFitness, idx]=min(fitness); 
% bestSolution=eco(idx,:);
% 
% fprintf('Best Fitness: %d\n', bestFitness);
% disp('Best Solution:'); 
% disp(bestSolution);

end

%% --- Boundary Handling --- 
function a=bound(a,ub,lb)
    a(a>ub)=ub(a>ub); a(a<lb)=lb(a<lb);
end