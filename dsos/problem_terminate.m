function [ecosize, n, maxFE, lb, ub] = problem_terminate()

    % Parameter settings:
   
    
    % ecosystem (population) size
    ecosize = 50;

    % problem dimension //tasarým parametre sayýsý
    n = 3;

    % number of function evaluations// arama uzayýnda geçirilecek
    % zaman//amaç fonks çaðýrma
    maxFE = 10000 * n;

    % problem lower band 
    lb = [0.05 0.25 2.0];

    % problem upper band
    ub = [2.0 1.3 15.0];

end

