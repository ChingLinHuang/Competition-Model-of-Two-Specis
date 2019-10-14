
plot_length = 10;
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
%{
n_sed = 400;
A_sed = zeros(n_sed, 4);
A_sed(1:end-2,1) = 1;
A_sed(end-1:end,1) = 2; 
A_sed(:,1) = randi([1 2],n_sed,1);% 2 species (uniformly)
A_sed(:,2) = abs(randn(n_sed,1) * 1) + 0.1; % dbh ~ abs(normal(0,15))+1
A_sed(:,3) = rand(n_sed,1) * plot_length; % x-coor between 0m to 10m
A_sed(:,4) = rand(n_sed,1) * plot_length; % y-coor between 0m to 10m
%}

A = [A_sap; A_juv; A_sed];

N = []; % difference of two sp
G1 = []; % # of sp1 after ger 
G2 = []; % # of sp2 after ger 
Gd1 = []; % # of sp1 after ger with dbh > 5
Gd2 = []; % # of sp2 after ger with dbh > 5 
M1 = []; % # of sp1 after mor
M2 = []; % # of sp2 after mor
Md1 = []; % # of sp1 after mor with dbh > 5 
Md2 = []; % # of sp2 after mor with dbh > 5 
B = []; % max dbh

video = VideoWriter('video_test'); %create the video object
video.FrameRate = 5;
open(video);
lop = 10000;
for i = 1:lop
    N = [N sum(A(:,1)==1) - sum(A(:,1)==2)];
    testInd = i
    A = ger(A,plot_length);
    G1 = [G1 sum(A(:,1)==1)];
    G2 = [G2 sum(A(:,1)==2)];
    Gd1 = [Gd1 sum(A(:,1)==1 & A(:,2)>5)];
    Gd2 = [Gd2 sum(A(:,1)==2 & A(:,2)>5)];
    %img = myplot(A,plot_length);
    %imwrite(img,'testImg'+string(2*i-1)+'.jpg')
    %writeVideo(video,img);
    A = gro(A);
    %img = myplot(A,plot_length);
    %imwrite(img,'testImg'+string(2*i)+'.jpg')
    %writeVideo(video,img);
    A = mor(A);
    img = myplot(A,plot_length);
    M1 = [M1 sum(A(:,1)==1)];
    M2 = [M2 sum(A(:,1)==2)];
    Md1 = [Md1 sum(A(:,1)==1 & A(:,2)>5)];
    Md2 = [Md2 sum(A(:,1)==2 & A(:,2)>5)];
    B = [B max(A(:,2))];
    %imwrite(img,'testImg'+string(2*i)+'.jpg')
    writeVideo(video,img);
    
    if M2(i)==0
        disp('Species 2 is extinct')
        break;
    end
end
close(video);

%{ 
sum(N<0)
plot(10:lop, N(10:end))
xlabel('year')
title("The number of species 1 - number of species 2 in plot")

plot(10:lop, Gd1(10:end))
hold on
plot(10:lop, Gd2(10:end))
xlabel('year')
title('The number of species 1 and species 2 after adding juveniles')
legend('sp1','sp2')

plot(10:lop, Md1(10:end))
hold on
plot(10:lop, Md2(10:end))
xlabel('year')
title('The number of species 1 and species 2 after mortality, dbh > 5, same mu')
legend('sp1','sp2')

plot(10:lop, M1(10:end)./G1(10:end))
hold on
plot(10:lop, M2(10:end)./G2(10:end))
xlabel('year')
title('The probability of species 1 and species 2 being alive in the year')
legend('sp1','sp2')

plot(1:lop, B)
xlabel('year')
ylabel('cm')
title('Largest dbh in the year')
%}

%Sort dbh and plot the relation of dbh and number of individual
%plot(sort(A(:,2)));
%hist(A(:,2),20);
%mortality
%A = mor(A);
