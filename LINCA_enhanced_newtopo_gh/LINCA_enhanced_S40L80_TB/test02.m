clear; clc;

n=6;
A = zeros(n,n);

counter01=0;
counter02=0;
for i = 1:n
	for j = 1:n
		counter01 = counter01 +1;	
		A(i,j) = counter01 + j;

	end

end

display(A);