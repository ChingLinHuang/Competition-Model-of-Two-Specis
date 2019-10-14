%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dispersal is a function to calculate the disperdal distance and direction 
% of each individual 
%
% input: 
%   n: number of generation
%   dbh: DBH of individual
%   k_dis: constant to adjust var
% output: 
%   vec: direction of dispersal (unit: meter)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function cor = dis (n, dbh, coordinate, k_dis, plot_length)
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %var = k_dis*dbh;
    pol = [abs(randn(n,1))*k_dis*(2+log(dbh)) + dbh/(2*pi)/100 , rand(n,1)*2*pi];
    cor = coordinate + [pol(:,1).*cos(pol(:,2)), pol(:,1).*sin(pol(:,2))];
    cor = cor( (cor(:,1) > 0 & cor(:,1) < plot_length).*(cor(:,2) > 0 & ...
    cor(:,2) < plot_length)==1,:);     
end
