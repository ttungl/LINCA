function [Btl_Neck, x, af, bn] = findBn( T,ee,z,isU )
    % find a leaving arc "x", 
    % Leaving arc is an arc on the cycle, pointing in the opposite direction to the entering arc "ee", 
    % and of all such arcs, it is the one with the smallest primal flow "bn".
    % "af" is the node from which the arc "x" goes to anohter node.
    
    % Copyright (c) 2011-2012 by Hongxun Jiang
    % Matlog Version 2 01-FEB-2012
    
    % Modification: Tung
    % output: return the bottle neck status, btl_Neck.
    
    n = length(z);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    %An  undirected path is  defined  in the  same way  as  a directed  path
    %except  that the orientation  of the  arcs  along  the path is inconsequential
    A = zeros(n);
    T1 = coVertex(T,n);
    A(T) = 1;    
    A(T1) = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %find the cycle path due to adding an entering arc "ee" into T.
    [x] = findCycle(A, ee, isU);    
	
	% when x=1, then len=1, so for-loop will run from 1->0, turning out that this is a logical false.
	len = length(x);
	
	if len <= 1
		% display('Hello lenOf_y <=1 !!!');
		Btl_Neck = 1;
		af=0; bn=0;		
		n=0; x=0;
		return;
	else
		Btl_Neck = 0; % Tung	
	end

	for i=1:len-1                                    
		y(i) = z(x(i),x(i+1));     
	end

	% display('findBn-y');
	% display(x);	
	% display(y);	

	try
		bn = min(y);                 %bottleNeck
		Btl_Neck = 0;
	catch bn
		Btl_Neck = 1; % error: bottle neck
		bn=0;
		return;
	end

	% display('findBn-bn');
	% display(bn);

	% Btl_Neck = 1; % Tung

	af = find(y == bn);			 %arc from

	if length(af) > 1     
		BN = FastFloyd(A);
		
		least = BN(n,:);                      
		X = least(x);                          
		i = find(X==min(X),1);    
		x(len) = [];			                 
		x = circshift(x,[1,-i+1]);             
		x(len) = x(1);                          
		
		for i=1:len-1                                    
			y(i) = z(x(i),x(i+1));
		end 
	   
		aff = find(y==bn); 
		af = max(aff);
	end

	
	
end

