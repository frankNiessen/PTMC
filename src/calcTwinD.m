function SD = calcTwinD(SP,M,varargin)
%[J.K. Mackenzie, J.S. Bowles, Acta Metall. 2 (1954) 138–147.]
%Equation (7.9)
scrPrnt('SegmentStart','Twinning Lattice Invariant Shear',varargin{:});
SP = SP';
SD = M^(-2)*SP/(SP'*M^(-2)*SP)-SP;                                     %Calculate twinning direction
SD = SD/norm(SD);                                                          %Normalize twinning direction
end