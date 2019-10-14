%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N_seed is the function to calculate the number of germinative seeds of
% each species
%
% input: 
%   mu_seed: mean
%   var_seed: variance
% output:
%   n: number of germinate seeds
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function n = N_seed(mu_seed, var_seed, nrow)
    n = fix(randn(nrow,1)*sqrt(var_seed)+mu_seed); 
end