function [BN_status, cost, minf ] = netSimplex( A, D, G )
% This function is an implementation of the primal simplex algorithm for computing the minimum cost flow, 
% given the the adjacency matrix A, the demand vector D and the arc cost matrix G.
% A must be a full square matrix, as well as G. 
% The number of rows/columns of A or G is equal to the number of nodes of D.

% Notes: This version of the primal simplex algorithm can handle a special case of a digraph considering circuits with the different costs,
% That is, G(i,j), the cost for moving from vertex i to vertex j, is not equal to G(j,i), and both are larger than zero.

% Copyright (c) 2011-2012 by Hongxun Jiang
% Matlog Version 2 01-FEB-2012
% This implementation refers to an earlier version provided by Naomichi
% Aoyama.

    %Inputting validation
    isValid = validInput( A,D,G );     
    if ~isValid
        display('Inputting validation fails!');
        BN_status = 0; % Tung
        cost = 0;        minf = [];        return;
    end
    
    %closes all the Biograph Viewer windows.
%     viewG([],1);
    
    %creat an auxilliary network and find a basic feasible tree solution
    [b,c,M,f,pi] = auxiNet( A,G,D ); %   
    
    cc = checkCycle(b);             %find circuits in the network
    
    z = b - f + f.';                %capacity upper bound matrix    
    T = find(c==M);                 %the arcs in the spanning tree 
    L = setxor(find(b),T);          %the nontree arcs whose flow = 0;    
    U = [];                         %the nontree arcs that are saturated

    bottle_Neck=0; % Tung
    BN_status=0;

    %Simplex Pivot:
    [L,U,ee,isU] = selArc(L,pi,c,U);   %select a feasible entering arc
    while ~isempty(ee)
        % [f,T,L,U] = pivot(f,z,T,L,U,ee,isU);
        [bottle_Neck,f,T,L,U] = pivot(f,z,T,L,U,ee,isU);
        if bottle_Neck == 1
            BN_status=1;
            % return;
            break;
        end    
        z = adjustCapacity(b,f,cc,T);   %adjust the capacity upper bound matrix 
        pi = pt(T,c);                   %Compute Node Potentials
        [L,U,ee,isU] = selArc(L,pi,c,U);%select a feasible entering arc         

    end

    minf = admissible(f);
    
    %computes the value of the cost of the given solution
    ttt = find(minf); 
    cost = sum(minf(ttt).*G(ttt));
    
%     display(ttt);% Tung-display
%     display(cost);% Tung-display
    
    
%      viewG(minf,0);  %view the graph


end
