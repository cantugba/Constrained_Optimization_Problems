function maliyet = amacFunction(x, index)
    
    if (index == 1)
            maliyet =  springDesignOptimization(x);
    elseif(index == 2)
            maliyet = heatExchangerNetworkDesignOptimization(x);
    elseif(index == 3)
            maliyet = heatExchangerNetworkDesignOptimization2(x);
    elseif(index == 4)
            maliyet = haverlysPoolingOptimization(x);
    end

end