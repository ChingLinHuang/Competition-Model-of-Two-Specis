
plot_length = 10;
extinct = 0;
for kk = 1:100
%Setting A
A = [];
% # of saplings 10
n_sap = 10;
A_sap = zeros(n_sap, 4);
A_sap(1:end-5,1) = 1;
A_sap(end-4:end,1) = 2;% 2 species (uniformly)
%A_sap(:,1) = randi([1 2],n_sap,1);
A_sap(:,2) = abs(randn(n_sap,1) * 15) +10; % dbh ~ abs(normal(0,15))+1
A_sap(:,3) = rand(n_sap,1) * plot_length; % x-coor between 0m to 10m
A_sap(:,4) = rand(n_sap,1) * plot_length;% y-coor between 0m to 10m
% # of juvenile 20
n_juv = 300;
A_juv = zeros(n_juv, 4);
A_juv(1:end-30,1) = 1;
A_juv(end-29:end,1) = 2; 
%A_juv(:,1) = randi([1 2],n_juv,1);% 2 species (uniformly)
A_juv(:,2) = abs(randn(n_juv,1) * 5) + 1; % dbh ~ abs(normal(0,15))+1
A_juv(:,3) = rand(n_juv,1) * plot_length; % x-coor between 0m to 10m
A_juv(:,4) = rand(n_juv,1) * plot_length; % y-coor between 0m to 10m
% # of seedlings 1500
A_sed = [];

A = [A_sap; A_juv; A_sed];
lop = 1000;
for i = 1:lop
    testInd = [kk i]
    A = ger(A,plot_length);
    if i > 200
        ind = (A(:,3) > i*5/800);
        A = A(ind,:);
    end

    A = gro(A);
    A = mor(A);
    if sum(A(:,1)==2)==0
        disp('Species 2 is extinct')
        extinct = extinct + 1;
        break;
    end
end

end
