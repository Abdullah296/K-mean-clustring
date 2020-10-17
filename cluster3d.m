Z = load( 'BCE_A1_3_2.txt');        %load text file
Z = transpose(Z);                   %convert (200*2) into (2*200)
B = Z(1,:);                         % x cordinate = b
C = Z(2,:);                         % y cordinate = c
M = Z(3,:);                         % z cordinate = m
abdullah = fopen('BCE_A1_3_2_output1234.txt', 'w');
n = 200;

%some temp arrays use for program
O = zeros(1, n);
L = zeros(1, n);
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

C1z = 0;
C2z = 0;

Cc = rand(1,6);
Cc(1) = C1x ;            %initial x cordinate of cluster1 
Cc(2) = C1y ;            %initial y cordinate of cluster1
Cc(3) = C1z ;            %initial z cordinate of cluster1
Cc(4) = C2x ;            %initial x cordinate of cluster2
Cc(5) = C2y ;            %initial y cordinate of cluster2
Cc(6) = C2z ;            %initial z cordinate of cluster2

%temp variable
q = 0;
w = 0;
t = 0;
e = 0;
r = 0;
y = 0;
p = 0;

%repeat until convergence
while (p < 1)
for i = 1:1:n               % n is total number of data points
    
     x = [B(i), C(i), M(i)];          %x contain data points
     y = [C1x, C1y, C1z];            %y contain cluster points 1
     distance = sqrt((x(1)-y(1))^2 + (x(2)-y(2))^2 + (x(3)-y(3))^2);         %calculate distance from data point to cluster 1

     %calculating distance from cluster 2
    x = [B(i), C(i), M(i)];          %x contain data points
    y = [C2x, C2y , C1z];            %y contain cluster points 1
    distance1 = sqrt((x(1)-y(1))^2 + (x(2)-y(2))^2 + (x(3)-y(3))^2);         %calculate distance from data point to cluster 2

    % check which distance is smallest 
    if ( distance < distance1)
         A(i) = distance;           % A array contain minimum distances
         D(i) = 1;                  % D array show it combine with 1st cluster or 2nd cluster
         E(i) = B(i);               % if it combine with 1, it x cordinate store in E array
         F(i) = C(i);               % and it y coordinate store in F array
         L(i) = M(i);
    else 
          A(i) = distance1;
          D(i) = 2;
          G(i) = B(i);              % if it combine with 2 cluster, it x cordinate store in G array
          H(i) = C(i);              % and it y coordinate store in H array
          O(i) = M(i);
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
C1z = 0;
C2x = 0;
C2y = 0;
C2z = 0;

    for i = 1:n
         C1x = C1x + E(i);
         C1y = C1y + F(i);
         C1z = C1z + L(i);
    end
         C1x = C1x/count1;
         C1y = C1y/count1;
         C1z = C1z/count1;           %adding all points and calculating their mid point

    for i = 1:n
        C2x = C2x + G(i);
        C2y = C2y + H(i);
        C2z = C2z + O(i);
    end
        C2x = C2x/count2;
         C2y = C2y/count2;
         C2z = C2z/count2;          %adding all points and calculating their mid point

    fprintf('\n(cluster1 = %d, %d, %d )',C1x, C1y, C1z);
    fprintf('(cluster2 = %d, %d, %d )\n',C2x, C2y, C2z);
    fprintf(abdullah,'(cluster1 = %d, %d, %d )',C1x, C1y, C1z);
    fprintf(abdullah, '(cluster2 = %d, %d, %d )',C2x, C2y, C2z);
    fprintf(abdullah, '\t');

if ((q == C1x) &&( w == C1y) && (e == C2x) && (r == C2y ));%&& (t == C1z) && (y == C2z ));
   %if(t == C1z && y == C2z)
    p = 2;
    break 
%end
end
q = C1x;
w = C1y;
t = C1z;
e = C2x;
r = C2y;
y = C2z;
end
fclose(abdullah);

