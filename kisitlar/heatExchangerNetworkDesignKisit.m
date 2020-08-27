function [ceza] = heatExchangerNetworkDesignKisit(x)

    h(1) = 200 * x(1) * x(4) - x(3);
    h(2) = 200 * x(2) * x(6) - x(5);
    h(3) = x(3) - 10000 * (x(7) - 100);
    h(4) = x(5) - 10000 * (300 - x(7));
    h(5) = x(3) - 10000 * (600 - x(8));
    h(6) = x(5) - 10000 * (900 - x(9));
    h(7) = x(4) * ln(x(8) - 100) - x(4) * ln(600 - x(7)) - x(8) + x(7) + 500;
    h(8) = x(6) * ln(x(9) - x(7)) - x(6) * ln(600) - x(9) + x(7) + 600;
    
    ceza = 100 * esitEsitKontrol(h,0,1000000);
    %hassasiyet?
  
end

