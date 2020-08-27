function amac = heatExchangerNetworkDesignOptimization (x)
    amac = 35 * x(1)^(0.6) + 35 * x(2)^(0.6);
    amac = amac + heatExchangerNetworkDesignKisit(x);  
end

