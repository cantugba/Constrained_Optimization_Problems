function [lb,ub] = haverlysPoolingAyarlar

    lb = [0 0 0 0 0 0 0 0 0];
    ub = [100 200 100 100 100 100 200 100 200];
    
    ub(1:6)=100;
    ub(7:9)=200;

end

