function [ceza] = heatExchangerNetworkDesignKisit2(x)
    
    h(1) = x(1) - (10^4)*(x(7) - 100);
    h(2) = x(2) - (10^4)*(x(8) - x(7));
    h(3) = x(3) - (10^4)*(500 - x(8));
    h(4) = x(1) - (10^4)*(300 - x(9));
    h(5) = x(2) - (10^4)*(400 - x(10));
    h(6) = x(3) - (10^4)*(600 - x(11));
    h(7) = x(4) * ln(x(9) - 100) - x(4) * ln(300 - x(7)) - x(9) - x(7) + 400;
    h(8) = x(5) * ln(x(10) - x(7)) - x(5) * ln(400 - x(8)) - x(10) + x(7) - x(8) + 400;
    h(9) = x(6) * ln(x(11) - x(8)) - x(6) * ln(100) - x(11) + x(8) + 100;
    
    ceza = 100 * esitEsitKontrol(h,0,5);
    %hassasiyet ayarý?
    
end

