%% Hexadecimal to Binary Conversion

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

function b = hex2bin(h)

bin = ['0000'
       '0001'
       '0010'
       '0011'
       '0100'
       '0101'
       '0110'
       '0111'
       '1000'
       '1001'
       '1010'
       '1011'
       '1100'
       '1101'
       '1110'
       '1111'];
   
   n = length(h); 
   
   for i = 1:n
      c = h(i); 
      v = c + 0; 
      
      if (v>=48) && (v <=57)
          v = v - 48;
      elseif (v >=65) && (v <=70)
          v = v - 65 + 10;
      end
      
      if i == 1
          b = bin(v+1,:);
      else
          b = [b, bin(v+1,:)];
      end 
   end

end