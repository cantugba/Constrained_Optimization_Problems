function [amac] = haverlysPoolingOptimization(x)

    amac = 9 * x(1) + 15 * x(2) - 6 * x(3) - 16 * x(4) - 10 * (x(5) + x(6));
    amac = amac + haverlysPoolingOptimization(x);
end

