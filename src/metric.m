function G = metric(CS,abc,varargin)
%Return metric of crystal structure CS
if ~isempty(varargin) && isa(varargin{1},'char') && strcmpi(varargin{1},'rel')
   mode = varargin{1};
else
   mode = [];
end
%Basis of A
if isa(CS,'char')
   A = basis(CS,abc,mode); 
elseif isa(CS,'double')&& all(size(CS)==[3,3])
   A = CS;
else
       error('Wrong input format');
end
%Reciprocal Basis of A
V = A(:,1)'*cross(A(:,2),A(:,3)); 
A_rec(:,1) = (cross(A(:,2),A(:,3))/V);                                     %[https://en.wikipedia.org/wiki/Dual_basis]
A_rec(:,2) = (cross(A(:,3),A(:,1))/V);                                     %[https://en.wikipedia.org/wiki/Dual_basis]
A_rec(:,3) = (cross(A(:,1),A(:,2))/V);                                     %[https://en.wikipedia.org/wiki/Dual_basis]
%Metric of A
G = A_rec\A;