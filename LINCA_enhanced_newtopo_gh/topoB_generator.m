% Topology B generating function
% Description: topology B includes four equal-sized clusters.
% 	Inputs: number of nodes in the network; max_cols; max_rows;  
% 	Outputs: a topological matrix B in different networks scale (64_8x8); (256_16x16); (1024_32x32); (numnodes_numColsxnumRows) and more.
% Author: Tung Le, CACS_ULLafayette, ttungl@gmail.com


% --------64------------
% num_nodes = 64;
% max_rows = 8; %
% max_cols = 4; 
% -----------------------

% --------256------------
num_nodes = 256;
max_rows = 16; % 1+15
max_cols = 8; 
% -----------------------

% --------1024------------
% num_nodes = 1024;
% max_rows = 32; % 
% max_cols = 16; 
% -----------------------

% --------4096------------
% num_nodes = 4096;
% max_rows = 64; % 
% max_cols = 32; 
% -----------------------


n_max = num_nodes/2; % n is #nodes in one of two equal-sized clusters in topo A.


% generate the shortlinks connection of topo A;

% fid = fopen('topoB_8x8_64_conn.txt','wt');
fid = fopen('topoB_16x16_256_conn.txt','wt');
% fid = fopen('topoB_32x32_1024_conn.txt','wt');
% fid = fopen('topoB_64x64_4096_conn.txt','wt');

fprintf(fid,'topoB;');
fprintf(fid,'\n');

n=1; % init 
max_rows_tem = max_rows;
split_count = max_rows_tem/2;
while n ~= n_max
	
	if n == n_max-(max_rows-1) % top-right
		while n~=n_max
			if n ~= split_count
				fprintf(fid,'%d',n);
				fprintf(fid,'-');
				fprintf(fid,'%d',n+1);
				fprintf(fid,'\n');
				% fprintf(fid,'\n');
			end
			n = n+1;
		end
		n=n_max; 
		break;
	end

	if n == split_count
		fprintf(fid,'%d',n);
		fprintf(fid,'-');
		fprintf(fid,'%d',n+max_rows); 
		fprintf(fid,'\n');
		% fprintf(fid,'\n');
		split_count = max_rows_tem + (max_rows/2);

	elseif n == max_rows_tem
		fprintf(fid,'%d',n);
		fprintf(fid,'-');
		fprintf(fid,'%d',n+max_rows); 
		fprintf(fid,'\n');
		% fprintf(fid,'\n');
		% update max_rows_tem
		max_rows_tem = max_rows_tem + max_rows;
		
	else
		fprintf(fid,'%d',n);
		fprintf(fid,'-');
		fprintf(fid,'%d',n+1);
		fprintf(fid,'\n');
		%------
		fprintf(fid,'%d',n);
		fprintf(fid,'-');
		fprintf(fid,'%d',n+max_rows);
		fprintf(fid,'\n');
	end

	n = n +1; % increment

end
fprintf(fid,'t;');
fclose(fid)







































