function basis = basis(CS,abc,varargin)
%Return basis of crystal structure CS
switch lower(CS)
    case {'bcc','fcc','m-3m','cubic','tetragonal'}
        basis = [1 0 0; 0 1 0; 0 0 1];
    case {'orthorhombic','mmm'}
        basis = [1 0 0; 0 1 0; 0 0 1];    
    case {'hexagonal','hcp'}
        basis = [sind(120) 0 0; cosd(120) 1 0; 0 0 1]; 
end

%If basis required in absolute length scale (otherwise relative unit vector)
if ~(~isempty(varargin) && isa(varargin{1},'char') && strcmpi(varargin{1},'rel'))
    basis = basis*[abc(1) 0 0; 0 abc(2) 0; 0 0 abc(3)];                    %Absolute basis in [Å]
end