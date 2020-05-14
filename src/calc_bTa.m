function bTa = calc_bTa(Laue_a,Laue_b,abc_a,abc_b,bCa,varargin) 
%function bTa = calc_bTa(Laue_a,Laue_b,abc_a,abc_b,bCa) 
%Calculate lattice transformation matrix
scrPrnt('SegmentStart','Lattice transformation matrix',varargin{:});
A = basis(Laue_a,abc_a,'rel');                                             %Get basis of A
B = basis(Laue_b,abc_b,'rel');                                             %Get basis of B
bTa = normc(B*A^(-1)*bCa);                                                 %Compute lattice transformation matrix
scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',bTa(1,:),bTa(2,:),bTa(3,:)),'_(bTa)'],varargin{:});