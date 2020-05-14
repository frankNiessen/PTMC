function bCaIni = def_bCa(CS)
switch strrep([CS.A.pointGroup,',',CS.B.pointGroup],' ','')    
    case {'m-3m,mmm'}
        bCaIni = [1 0 0; 0 0.5 -0.5;0 0.5 0.5];                            %cubic -> orthorhombic (Ti beta->alpha'')
    case {'m-3m,m-3m'} 
        bCaIni = [1 -1 0; 1 1 0;0 0 1];                                    %cubic (fcc) -> (bc[c/t])
        %bCaIni = [0.5 0.5 0; -0.5 0.5 0;0 0 1];                            %cubic (bc[c/t]) -> (fcc)
    case {'m-3m,6/mmm'} % cubic->hcp
        bCaIni = [1 0.5 0.5; 0 1 1;0 -0.5 0.5];                            %cubic -> hcp
    case {'6/mmm,m-3m'} % hcp->cubic
        bCaIni = [1 -0.5 0; 0 0.5 -1;0 0.5 1.0];                           %hcp -> cubic
    otherwise
        bCaIni = [];        
end