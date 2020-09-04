%% Decimal to Binary Conversion

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

function b = dec2bin(d)

b = hex2bin(dec2hex(d)); 

end