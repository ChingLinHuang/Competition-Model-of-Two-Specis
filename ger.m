%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% germinate is the function to get seedlings
% Assumptions:
%
% input:
%   A: matrix of distribution
% output:
%   A_new: A added seedlings
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A_new = ger(A, plot_length)
%%%%% parameters  %%%% 
mu1_seed = 20; % expect 10 seedlings germinated each individual
mu2_seed = 20;
var_seed = 2;
k_dis = 0.5;
n = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nrow, ncol] = size(A);
n1 = N_seed(mu1_seed, var_seed, sum(A(:,1)==1));
n2 = N_seed(mu2_seed, var_seed, sum(A(:,1)==2));
n(A(:,1)==1)=n1;
n(A(:,1)==2)=n2;

radius = A(:,2)/(2*pi)/100;
newA = [];
for i = 1 : nrow
    if A(i,2)>5 % dbh > 5
        %test = i
        cor = dis(n(i), A(i,2), A(i,3:4), k_dis, plot_length);
        [nrow_cor, ncol_cor] = size(cor);
        for j = 1 : nrow_cor
            ind = (A(:,3)< cor(j,1)+1)&(A(:,3) > cor(j,1)-1).* ...
            (A(:,4)< cor(j,2)+1)&(A(:,4)> cor(j,2)-1);
   
            K = A(ind,3:4) - cor(j,:); 
            if sum((K(:,1).^2 + K(:,2).^2) < radius(ind).^2) == 0  % delete the seedlings that aren't in some tree's radius
                newA = [newA; A(i,1) (rand(1)*0.45 + 0.05) cor(j,:)];
            end
        end
    end
        % Note that there may be some seedling are overlapping
end

A_new = [A; newA];


