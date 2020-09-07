%% Function to Print a Message

% The following code is adapted from code provided my M. A. van Wyk.
% 30/03/1993

function prompt(text)
fprintf('\n\n')
fprintf(text)
fprintf('\n\n')
fprintf('\nPress any key to continue')
pause
fprintf('\n\n')
end