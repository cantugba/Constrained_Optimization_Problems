function [ceza] = springDesignKisit(x)
   l = x(3);
   d = x(2);
   w = x(1);
  
   g(1) = 1 - ((d^2*l) / (7178*w^4));
   g(2) = ((4*d^2 - w*d) / (12566*d*w^3 - w^4)) + (1/(5108*w))-1;
   g(3) = 1 - ((140.45*w) / (d^2*l));
   g(4) = ((w+d)/1.5) - 1;
   
   ceza = 100000000 * kucukEsitKontrol(g, 0);
end