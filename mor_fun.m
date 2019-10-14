%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% Construct a mortality rate function
% input: 
%   A: 
% output: 
%   p: mortality rate
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p = mor_fun(A)
[nrow, ncol] = size(A);
% Setup the mortality rate function
% f1(x) = c1*(x-27)^k1 + 0.01
% f2(x) = c2*(x-27)^k2 + 0.01
% c1*(10-27)^k1 +0.01 < 0.015
% c1*(0-27)^k1 +0.01 > 0.08
% c2*(50-27)^k2 +0.01 < 0.02
% c2*(70-27)^k2 +0.01 > 0.08
c1 = 1.8068e-10;
c2 = 2.0475e-08;
k1 = 6;
k2 = 4;

p = zeros(nrow,1);
p(A(:,2)<=27) = c1*(A(A(:,2)<=27,2)-27).^k1+0.01;
p(A(:,2)>27) = c2*(A(A(:,2)>27,2)-27).^k2+0.01;

% If S1-S2 = N > 0
% p1 = f(x1)*(a1*(n1/d11^2)*(1+log(N)) + a2* delta(dbh) + a3*(n2/d12^2))
% p2 = f(x2)*(b1*(n1/d21^2)*(1-log(N)) + b2* delta(dbh) + b3*(n2/d22^2))
% 1+sign(N)*log(abs(N))



M = sum(A(:,1)==1)/(sum(A(:,1)==1) + sum(A(:,1)==2));
%N = N-500;
for i = 1:nrow
    ind = (A(:,3)< A(i,3)+1)&(A(:,3) > A(i,3)-1)& ...
            (A(:,4)< A(i,4)+1)&(A(:,4)> A(i,4)-1)&((1:nrow)'~=i);
    A_intra = A(ind &(A(:,1)==A(i,1)),:);
    A_inter = A(ind &(A(:,1)~=A(i,1)),:);
    N = sum(A(ind,1)==1) - sum(A(ind,1)==2);
    N = 30*N;
    
    [max_intra ind_intra ]= max(A_intra(:,2)); % max dbh
    [max_inter ind_inter ]= max(A_inter(:,2));
        if sum(ind_intra)>0    
            d_intra = ((A_intra(ind_intra,3)-A(i,3))^2 + (A_intra(ind_intra,4)-A(i,4))^2)^0.5; % difference of coordinate
            d_intra = d_intra - (A_intra(ind_intra,2)+A(i,2))/(200*pi); % minus radius
        else
            d_intra = 1;
            max_intra = 0.1;
        end
        
        if sum(ind_inter)>0
            d_inter = ((A_inter(ind_inter,3)-A(i,3))^2 + (A_inter(ind_inter,4)-A(i,4))^2)^0.5;
            d_inter = d_inter - (A_inter(ind_inter,2)+A(i,2))/(200*pi); 
        else
            d_inter = 1;
            max_inter = 0.1;
        end
    
        if abs(N) > 0 
            if (A(i,1)==1 & N>0) | (A(i,1)==2 & N<0)
                p(i) = p(i)*max([( log(2+length(ind)+max_intra) / (0.01+d_intra/(1+log(abs(N)))) /(10*A(i,2))), ...
                    (log(2+length(ind)+max_inter)/(0.01+d_inter*(1+log(abs(N))))/(10*A(i,2)))]);
            else
                p(i) = p(i)*max([(log(2+length(ind)+max_intra)/(0.01+d_intra*(1+log(abs(N))))/(10*A(i,2))), ...
                    (log(2+length(ind)+max_intra)/(0.01+d_intra)/(10*A(i,2)))]);
            end
        
        else 
            p(i) = p(i)*max([(log(2+length(ind)+max_intra)/(0.01+d_intra)/(10*A(i,2))), ...
                (log(2+length(ind)+max_intra)/(0.01+d_intra)/(10*A(i,2)))]);
        end
        % Consider the competition
        if M < 0.8 & A(i,1)==1
            p(i) = p(i)*0.3;
        end
        if M > 0.8 & A(i,1)==1
            p(i) = p(i)*(0.3+(M-0.8)*0.7);
        end
        
end
p = p.*1.5; % c = 1.5
p(p>1)=1;
p(p<0.01)=0.01;

end
%}




