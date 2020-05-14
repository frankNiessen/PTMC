%[C.M. Wayman - Introduction to the crystallography of martensitic
%transformations, Example of Bowles Mackenzie on steel - p. 123]
% Transformation from crystal A to crystal B
function PTMC = mainPTMC(CSa,CSb,SPa,SDa,bCa,varargin)
%% PreProcessing
scrPrnt('Step',sprintf('Transformation A -> B / ''%s'' -> ''%s''',CSa.lattice,CSb.lattice),varargin{:});
abc_a = [CSa.aAxis.abs,CSa.bAxis.abs,CSa.cAxis.abs];
abc_b = [CSb.aAxis.abs,CSb.bAxis.abs,CSb.cAxis.abs];
scrPrnt('SubStep',sprintf('Crystal A: ''%s'' a: %.4f; b:%.4f; c: %.4f',...
                  CSa.lattice,abc_a),varargin{:});
scrPrnt('SubStep',sprintf('Crystal B: ''%s'' a: %.4f; b:%.4f; c: %.4f',...
                  CSb.lattice,abc_b),varargin{:});
scrPrnt('Step',sprintf('Lattice correspondence:'),varargin{:});
scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',bCa(1,:),bCa(2,:),bCa(3,:)),'_(bCa)'],varargin{:});
%Transpose plane normals to line vectors
SPa = SPa';
%Normalize planes and directions 
SPa = SPa/norm(SPa);                                                       %Normaloze LIS plane
if ~isa(SDa,'char'); SDa = SDa/norm(SDa); end                              %Normalize LIS direction
%Calculate Lattice transformation and Bain matrix
bTa = calc_bTa(CSa.lattice,CSb.lattice,abc_a,abc_b,bCa,varargin{:});       %Compute Lattice transformation matrix
M = calcM(CSa.LaueName,CSb.lattice,abc_a,abc_b,bCa,bTa,varargin{:});       %Compute Bain-Strain matrix
%% Twinning direction of lattice invariant shear
if isa(SDa,'char') && strcmpi(SDa,'twinning')
   SDa = calcTwinD(SPa,M.A,varargin{:});
end
scrPrnt('Step',sprintf('Twinning plane: (%.2f %.2f %.2f)_(A)',SPa),varargin{:});
scrPrnt('Step',sprintf('Twinning direction: [%.2f %.2f %.2f]_(A)',SDa),varargin{:});
% Transform directions to child crystal B
SPb = (SPa*bTa^(-1)); 
SDb = bTa*SDa; 
%% Invariant lines (IL) and normals (IN) 
scrPrnt('SegmentStart','Invariant lines (IL) and normals (IN) ',varargin{:});
IL = calcIL(SPb,bTa,bCa,M.B*ones(3,1),'line',varargin{:});                 %Compute invariant line
scrPrnt('Step',sprintf('IL1: (%.4f %.4f %.4f)_(A)',IL.A(:,1)),varargin{:});
scrPrnt('Step',sprintf('IL2: (%.4f %.4f %.4f)_(A)',IL.A(:,2)),varargin{:});
IN = calcIL(SDb,bTa,bCa,M.B*ones(3,1),'normal',varargin{:});               %Compute invariant normal
scrPrnt('Step',sprintf('IN1: (%.4f %.4f %.4f)_(A)',IN.A(:,1)),varargin{:});
scrPrnt('Step',sprintf('IN2: (%.4f %.4f %.4f)_(A)',IN.A(:,2)),varargin{:});
%% Compute PTMC solution
PTMC = calcPTMC(SPa,SDa,IL.A,IN.A,M.A,bTa,bCa,varargin{:});
PTMC.IL = IL;
PTMC.IN = IN;
PTMC.M = M;
