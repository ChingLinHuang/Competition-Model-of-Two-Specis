function A_new = mor(A)
% remove the trees on the margin
A = remove(A);
[nrow,ncol] = size(A);
p = mor_fun(A);
judge = rand(nrow,1);
A_new = A(p<judge,:);
%scatter(A(:,2),p)
end
