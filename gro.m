%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% growth function
% every tree with dbh > 5 widen 0.1 cm
% every tree with dbh < 5 widen 0.2 cm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function A = gro(A)
A(:,2) = A(:,2) + 0.1;
A(A(:,2)<5,2) = A(A(:,2)<5,2)+0.1;
end