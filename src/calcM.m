function M = calcM(Laue_a,Laue_b,abc_a,abc_b,bCa,bTa,varargin)
%function M = calcM(Laue_a,Laue_b,abc_a,abc_b,bCa,bTa)
%Calc lattice deformation matrix (Bain matrix)
%[J.K. Mackenzie, J.S. Bowles, Acta Metall. 2 (1954) 138–147.]
%Equation (4.1)
scrPrnt('SegmentStart','Lattice deformation (Bain) matrix',varargin{:});
%% Factors
aGa = metric(Laue_a,abc_a);
bGb = metric(Laue_b,abc_b);
%% Solve for mu and x
syms muSq x1 x2 x3                                                         %Define Symbols
eqns = [det(bCa'*bGb*bCa-muSq*aGa) == 0;...
        (bCa'*bGb*bCa-muSq*aGa)*[x1;x2;x3] == 0;...
        norm([x1;x2;x3]) ~=0];                                             %Define Equations
vars = [muSq x1 x2 x3];                                                    %Define Variables
S = solve(eqns,vars,'real',true);                                          %Solve equations         
clear muSq x1 x2 x3
%Get results
muSq = S.muSq;
x1 = double([S.x1(1);S.x2(1);S.x3(1)]);
x2 = double([S.x1(2);S.x2(2);S.x3(2)]);
x3 = double([S.x1(3);S.x2(3);S.x3(3)]);
P = [x1,x2,x3];                                                            %Orthonormal set of vectors in A
M.B = double(sqrt([muSq(1) 0 0; 0 muSq(2) 0; 0 0 muSq(3)]));               %Lattice Strain (Bain) matrix
R = eye(3)/P/bCa;                                                          %Rotation of M to correspond to eye matrix in A
M.B = R^(-1)*M.B*R;                                                        %Rotate M
M.A = bTa^(-1)*M.B*bTa;
scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',M.B(1,:),M.B(2,:),M.B(3,:)),'_(B)'],varargin{:});
scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',M.A(1,:),M.A(2,:),M.A(3,:)),'_(A)'],varargin{:});