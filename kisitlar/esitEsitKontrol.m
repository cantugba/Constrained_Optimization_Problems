function [ceza] = esitEsitKontrol (kisitlar, kontrolNoktasi,hassasiyet)

    [~, kisitSize] = size(kisitlar);
    ceza = 0;
    
    for i=1:kisitSize
        if ~(kontrolNoktasi+hassasiyet >= kisitlar(i) && kontrolNoktasi-hassasiyet <= kisitlar(i))
            ceza = ceza + abs(kisitlar(i));
        end
    end
end