% Topology A generating function
% num_nodes = 1024;
% Description: topology A includes two equal-sized clusters.
% 	Inputs: number of nodes in the network; max_cols; max_rows;  
% 	Outputs: a topological matrix A in different networks scale (64_8x8); (256_16x16); (1024_32x32); (numnodes_numColsxnumRows) and more.
% Author: Tung Le, CACS_ULLafayette, ttungl@gmail.com


% --------16------------
% num_nodes = 16;
% max_rows = 4; % 1+3
% max_cols = 2; 
% -----------------------

% --------32------------
% num_nodes = 32;
% max_rows = 8; % 1+7
% max_cols = 2; 
% -----------------------

% --------64------------
% num_nodes = 64;
% max_rows = 8; % 1+7
% max_cols = 4; 
% -----------------------

% --------128------------
num_nodes = 128;
max_rows = 16; % 1+7
max_cols = 4; 
% -----------------------

% --------256------------
% num_nodes = 256;
% max_rows = 16; % 1+15
% max_cols = 8; 
% -----------------------

% --------512------------
% num_nodes = 512;
% max_rows = 16; 
% max_cols = 16; 
% -----------------------

% --------1024------------
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

% fid = fopen('topoA_4x4_16_conn.txt','wt'); 
% fid = fopen('topoA_8x4_32_conn.txt','wt'); 
fid = fopen('topoA_16x8_128_conn.txt','wt'); 

% fid = fopen('topoA_8x8_64_conn.txt','wt'); 
% fid = fopen('topoA_16x16_256_conn.txt','wt');
% fid = fopen('topoA_16x32_512_conn.txt','wt'); 
% fid = fopen('topoA_32x32_1024_conn.txt','wt'); 
% fid = fopen('topoA_64x64_4096_conn.txt','wt'); 


fprintf(fid,'topoA;');
fprintf(fid,'\n');

n=1; % init 
max_rows_tem = max_rows;

while n ~= n_max
	if n == n_max-(max_rows-1) % top-right
		while n~=n_max
			fprintf(fid,'%d',n);
			fprintf(fid,'-');
			fprintf(fid,'%d',n+1);
			fprintf(fid,'\n');
			n = n+1;
		end
		n=n_max; 
		break;
	end

	if n == max_rows_tem
		fprintf(fid,'%d',n);
		fprintf(fid,'-');
		fprintf(fid,'%d',n+max_rows); 
		fprintf(fid,'\n');
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
		% fprintf(fid,'%d',n+16);
		fprintf(fid,'\n');
	end

	n = n +1; % increment

end
fprintf(fid,'t;');
fclose(fid)







































