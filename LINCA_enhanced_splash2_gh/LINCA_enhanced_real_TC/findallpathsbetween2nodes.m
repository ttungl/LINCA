clear; clc;

% -----------------
% Input : A
% Output: all paths from a given source to a given destination, associated with its commodity, in A.
% Description: 
% A has three paths,
% p1: 1-2-3-4-8-12-16  (1) 
% p2: 1-2-3-7-11-15-16  (2)
% p3: 1-5-6-10-14-15-16  (3)
% with its total weight is 6.
% Function used: pathbetweennodes(). Thanks to Kelly Kearney.
% link: http://kellyakearney.net/matlabdoc/MiscResearch/pathbetweennodes.html
% -----------------

A = [
0 3 0 0 3 0 0 0 0 0 0 0 0 0 0 0
0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 1 0 0 2 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 3 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
];
src_org=1;
dst_org=16;
trafficVal = 6;

path1 = pathbetweennodes(A, src_org, dst_org, trafficVal, false);
% celldisp(path1);
ii=0;
while ii~=size(path1,1)
	ii=ii+1;
	% output: source dest path its_traffic
	path1{ii} = [src_org dst_org path1{ii}];
	fprintf('%2d ', path1{ii});
	fprintf('\n');
end
