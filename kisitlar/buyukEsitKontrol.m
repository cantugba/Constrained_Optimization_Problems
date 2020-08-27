function [ceza] = buyukEsitKontrol (kisitlar, kontrolNoktasi)

    [~, kisitSize] = size(kisitlar);
    ceza = 0;
    for i=1:kisitSize
        if kisitlar(i) < kontrolNoktasi
            ceza = ceza + kisitlar(i);
        end
    end


end