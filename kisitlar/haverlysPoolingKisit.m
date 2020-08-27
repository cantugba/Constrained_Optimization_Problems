function [ceza1,ceza2] = haverlysPoolingKisit(x)
        
    h(1) = x(7) + x(8) - x(4) - x(3);
    h(2) = x(1) - x(5) - x(7);
    h(3) = x(2) - x(6) - x(8);
    h(4) = x(9) * x(7) + x(9) * x(8) -3 * x(3) - x(4);
    g(1) = x(9) * x(7) + 2 * x(5) - 2.5 * x(1);
    g(2) = x(9) * x(8) + 2 * x(6) - 1.5 * x(2);
    
    ceza1 = 100 * esitEsitKontrol(h,0,50);
    ceza2 = 100 * kucukEsitKontrol(g,0);
    %hassasiyet ayarý
end

