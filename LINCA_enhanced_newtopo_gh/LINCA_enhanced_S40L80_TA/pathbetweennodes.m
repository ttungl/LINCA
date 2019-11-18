function pth = pathbetweennodes(adj, src, snk, trafficValue, verbose)
%PATHBETWEENNODES Return all paths between two nodes of a graph
%
% pth = pathbetweennodes(adj, src, snk)
% pth = pathbetweennodes(adj, src, snk, vflag)
%
%
% This function returns all simple paths (i.e. no cycles) between two nodes
% in a graph.  Not sure this is the most efficient algorithm, but it seems
% to work quickly for small graphs, and isn't too terrible for graphs with
% ~50 nodes.
%
% Input variables:
%
%   adj:    adjacency matrix
%
%   src:    index of starting node
%
%   snk:    index of target node
%
%   vflag:  logical scalar for verbose mode.  If true, prints paths to
%           screen as it traverses them (can be useful for larger,
%           time-consuming graphs). [false]
%
% Output variables:
%
%   pth:    cell array, with each cell holding the indices of a unique path
%           of nodes from src to snk.

% Copyright 2014 Kelly Kearney

% ---------------------------------------------------------
% Modified by: Tung Le
% Email: ttungl@gmail.com
% Appreciation to the original author Kelly Kearney.
% Description: 
% Additional input: 
% - trafficValue: to check total traffic from a given s-d pair.
% Additional output:
% - path & its traffic
% ---------------------------------------------------------


if nargin < 4
    verbose = false;
end

n = size(adj,1);

stack = src;

stop = false;

pth = cell(0);
cycles = cell(0);

next = cell(n,1);
for in = 1:n
    next{in} = find(adj(in,:));
end

visited = cell(0);


% ------ Tung
count1=0; count2=0; count3=0; 
stack_src=0; stack_dst=0; stack_tem=0; 
[rowsA,colsA] = size(adj); 
min_linkvalue_onPath_tem = 0; min_linkvalue_onPath=0; 
total_traffic = 0; % check with trafficValue
% -------------------

pred = src;
while 1
    
    visited = [visited; sprintf('%d,', stack)];
    [stack, pred] = addnode(stack, next, visited, pred);
    if verbose   
        fprintf('%2d ', stack);
        fprintf('\n');
    end
    
    if isempty(stack)
        break;
    end
    
    if stack(end) == snk
        % ------- Tung
        % obtain min value on each link.
        count1 = count1 +1;
        % find min value of links on path
        for k =1:length(stack)-1
            count2 = count2 +1;
            if count2==1
                stack_src = stack(k);
                stack_dst = stack(k+1);
            else
                stack_src = stack_tem;
                stack_dst = stack(k+1);
            end
            stack_tem = stack(k+1);

            % check weight of link in A to update min value
            for i=1:rowsA
                for j=1:colsA
                    if i ==stack_src && j ==stack_dst && adj(stack_src,stack_dst)~=0
                        min_linkvalue_onPath_tem = adj(i,j); % update min value
                        %
                        count3=count3+1;
                        if count3==1
                            min_linkvalue_onPath = min_linkvalue_onPath_tem;
                        end
                        %
                        if min_linkvalue_onPath_tem < min_linkvalue_onPath
                            min_linkvalue_onPath = min_linkvalue_onPath_tem; % update min value
                            break;
                        end
                    end
                end
            end
        end
        % ------ Tung
        count2 =0; count3=0;% reset
        stack_src=0; stack_dst=0; stack_tem=0; % reset
        stack(end+1) = min_linkvalue_onPath; % add traffic value into pth.
        % ----------

        pth = [pth; {stack}];
        
        visited = [visited; sprintf('%d,', stack)];
        stack = popnode(stack);
    elseif length(unique(stack)) < length(stack)
        cycles = [cycles; {stack}];
        visited = [visited; sprintf('%d,', stack)];
        stack = popnode(stack);  
    end
    
end

function [stack, pred] = addnode(stack, next, visited, pred)

newnode = setdiff(next{stack(end)}, pred);
possible = arrayfun(@(x) sprintf('%d,', [stack x]), newnode, 'uni', 0);

isnew = ~ismember(possible, visited);

if any(isnew)
    idx = find(isnew, 1);
    stack = str2num(possible{idx});
    pred = stack(end-1);
else
    [stack, pred] = popnode(stack);
end


function [stack, pred] = popnode(stack)

stack = stack(1:end-1);
if length(stack) > 1
    pred = stack(end-1);
else
    pred = [];
end



    
    
    



   
    
        