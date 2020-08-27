function [amac] = heatExchangerNetworkDesignOptimization2(x)

    amac = ((x(1) / (120 * x(4))^0.6)) + ((x(2) / (80 * x(5))^0.6)) + ((x3/(40 * x(6))^0.6));
    amac = amac + heatExchangerNetworkDesignKisit2(x);
    
end

