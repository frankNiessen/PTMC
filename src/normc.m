function y = normc(x)
%NORMC Normalize columns of matrices.
%
%  <a href="matlab:doc normc">normc</a>(X) takes a single matrix or cell array of matrices and returns
%  the matrices with columns normalized to a length of one.
%
%  Here the columns of a random matrix are normalized.
%
%    x = <a href="matlab:doc rands">rands</a>(4,8);
%    y = <a href="matlab:doc normc">normc</a>(x)
%
%  See also NORMR.

% Copyright 1992-2015 The MathWorks, Inc.

if nargin < 1
    error(message('nnet:Args:NotEnough'));
end
wasMatrix = ~iscell(x);
x = nntype.data('format',x,'Data');

y = cell(size(x));
for i=1:numel(x)
    xi = x{i};
    xi(~isfinite(xi)) = 0;
    len = sqrt(sum(xi.^2,1));
    yi = bsxfun(@rdivide,xi,len);
    zeroColumns = find(len==0);
    if ~isempty(zeroColumns)
        numRows = size(xi,1);
        row = ones(numRows,1) ./ sqrt(numRows);
        yi(:,zeroColumns) = repmat(row,1,numel(zeroColumns));
    end
    y{i} = yi;
end

if wasMatrix
    y = y{1};
end