%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove function
% if the trees overlap or too close, remove the smaller one
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function A_new = remove(A)
[nrow,ncol] = size(A);
A_new = [];
for i = 1:nrow
    L = 1;
    ind = (A(:,3)< A(i,3)+L)&(A(:,3) > A(i,3)-L)& ...
            (A(:,4)< A(i,4)+L)&(A(:,4)> A(i,4)-L)&((1:nrow)'~=i);
    N = sum(ind);
    dbh = A(ind,2);
    d = ((A(ind,3)-A(i,3)).^2 + (A(ind,4)-A(i,4)).^2).^0.5; % difference of coordinate
    d = d - (1+N).*(dbh + A(i,2))./(200*pi); % minus radius
    
    if min(d)>0 | (min(d)<0 & A(i,2)>=max(dbh(d<=0)))
        A_new = [A_new ;A(i,:)];
    end
    
end
