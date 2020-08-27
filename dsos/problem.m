function [ y ] = problem( x )

      y = (2 + x(3)) * x(2)*x(1)^2;
      y = y + springDesignKisit(x);
    
end

% function [ y ] = problem( x )
% 
%       y = 35 * x(1)^(0.6) + 35 * x(2)^(0.6);
%       y = y + heatExchangerNetworkDesignKisit(x);
%     
% end
