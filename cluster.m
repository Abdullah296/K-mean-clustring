
Z = load( 'BCE_A1_2_2.txt');        %load text file
Z = transpose(Z);                   %convert (200*2) into (2*200)
B = Z(1,:);                         % x cordinate = b
C = Z(2,:);                         % y cordinate = c
abdullah = fopen('BCE_A1_2_2_output.txt', 'w');  %output file name = 'BCE_A1_2_2_output.txt';
n = 200;

%some temp arrays use for program

% contain smallest distance
A = zeros(1, n);
% data points goes to first cluster or second
D = zeros(1, n);
%contain x cordinate of cluster 1 points
E = zeros(1, n);
%contain y cordinate of cluster 1 points
F = zeros(1, n);
%contain x cordinate of cluster 2 points
G = zeros(1, n);
%contain y cordinate of cluster 2 points
H = zeros(1, n);
Cc = rand(1,4) ;
%C1x = Cc(1) ;            %initial x cordinate of cluster1 
%C1y = Cc(2) ;            %initial y cordinate of cluster1
%C2x= Cc(3)  ;            %initial x cordinate of cluster2
%C2y= Cc(4)  ;            %initial y cordinate of cluster2

C1x = 3 ;            %initial x cordinate of cluster1 
C1y = 2 ;            %initial y cordinate of cluster1
C2x= 0  ;            %initial x cordinate of cluster2
C2y= 1  ;
q = 0;
w = 0;
e = 0;
r = 0; 
p = 0;

%repeat until convergence
while (p < 1)
for i = 1:1:n                   %n = datapoints
    
     x = [B(i), C(i)];          %x contain data points
     y = [C1x, C1y];            %y contain cluster points 1
     distance = sqrt((y(1)-x(1))^2 + (y(2)-x(2))^2);         %calculate distance from data point to cluster 1

     %calculating distance from cluster 2
     x = [B(i), C(i)];          %x contain data points
     y = [C2x, C2y];            %y contain cluster points 1
     distance1 = sqrt((y(1)-x(1))^2 + (y(2)-x(2))^2);          %calculate distance from data point to cluster 2

     % check which distance is smallest 
    if ( distance < distance1)
         A(i) = distance;           % A array contain minimum distances
         D(i) = 1;                  % D array show it combine with 1st cluster or 2nd cluster
         E(i) = B(i);               % if it combine with 1, it x cordinate store in E array
         F(i) = C(i);               % and it y coordinate store in F array
    else 
          A(i) = distance1;
          D(i) = 2;
          G(i) = B(i);              % if it combine with 2 cluster, it x cordinate store in G array
          H(i) = C(i);              % and it y coordinate store in H array
    end
end

    count1 = 0;         
    count2 = 0;

    for i = 1:n
        if( E(i) == 0)
            count1 = count1 + 0;
        else 
            count1 = count1 + 1;        %calculate how many data points attached with cluster 1
        end
    end
    
    for g = 1:n
        if( G(g) == 0)
            count2 = count2 + 0;
        else 
            count2 = count2 + 1;        %calculate how many data points attached with cluster 2
        end
    end
    
C1x = 0;
C1y = 0;
C2x = 0;
C2y = 0;

    for i = 1:n
        C1x = C1x + E(i);
        C1y = C1y + F(i);
    end
     C1x = C1x/count1;
     C1y = C1y/count1;          %adding all points and calculating their mid point
     
    for i = 1:n
        C2x = C2x + G(i);
        C2y = C2y + H(i);
    end
     C2x = C2x/count2;
     C2y = C2y/count2;          %adding all points and calculating their mid point

    fprintf('\n(cluster1 = %d, %d )',C1x, C1y);
    fprintf('(cluster2 = %d, %d )\n',C2x, C2y);
    fprintf(abdullah,'(cluster1 = %d, %d )',C1x, C1y);
    fprintf(abdullah, '(cluster2 = %d, %d )',C2x, C2y);
    fprintf(abdullah, '\t');

if (q == C1x && w == C1y && e == C2x && r == C2y )
    p = 2;
    break
end
q = C1x;
w = C1y;
e = C2x;
r = C2y;

end
fclose(abdullah);

hold on
plot(E,F,'o','MarkerSize', 5);
plot(G,H,'o','MarkerSize',5);
plot(C1x, C1y,'-s','MarkerSize',10);
plot(C2x, C2x,'-s','MarkerSize',10);

hold off

