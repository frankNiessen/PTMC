function M = normc(M)
%Normalize each column of matrix M

n = sqrt(sum(M.^2,1)); % Compute norms of columns
M = bsxfun(@rdivide,M,n); % Normalize M
