function out = calcIL(LIS,bTa,bCa,M,mode,varargin)
%function IL = calcIL(LIS,bTa,bCa,M)
%Compute invariant line/normal IL by solving equation system
try
    if strcmpi(mode,'normal')
       M = M.^(-1);                                                            %Invert M
       LIS = LIS';
    end
    syms IL1 IL2 IL3                                                           %Equation symbols ß vector IL
    eqns = [(M(1)^2-1)*IL1^2+(M(2)^2-1)*IL2^2+(M(3)^2-1)*IL3^2 == 0;...        %Bain strain should not change magnitude of IL
            LIS*[IL1 IL2 IL3]' == 0;...                                        %IL should be in the invariant shear plane
            sum(([IL1 IL2 IL3]).^2) == 1];                                     %Magnitude of IL should be 1
    S = solve(eqns,[IL1 IL2 IL3],'real',true);                                 %Solve equations

    IL = double([S.IL1(2) S.IL2(2) S.IL3(2)]);                                 %Get numeric value of IL
    IL = IL/norm(IL);
    IL(2,:) = double([S.IL1(1) S.IL2(1) S.IL3(1)]);                            %Get 2nd solution for IL
    IL(2,1:3) = IL(2,1:3)/norm(IL(2,1:3));
    assert(~any([isempty(S.IL1),isempty(S.IL2),isempty(S.IL3)]),'No solution!');
    if strcmpi(mode,'line')
        out.A = bTa^(-1)*IL';
        out.B = bCa*out.A;

    elseif strcmpi(mode,'normal')
        out.A = (IL*bTa)';
        out.B = (out.A'*bCa^(-1))';  
    end
    out.B(1:3,1) = out.B(1:3,1)/norm(out.B(1:3,1));
    out.B(1:3,2) = out.B(1:3,2)/norm(out.B(1:3,2));
catch ME
    warning('Computation of invariant %s unsuccesful - reconsider input parameters.',mode);
    rethrow(ME);
end