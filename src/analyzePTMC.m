function PTMC = analyzePTMC(PTMCin,SDa,CS,TRIP,varargin)
scrPrnt('Step','Analyzing PTMC result');
if length(PTMCin) ==  1 && length(TRIP.vars) ~=1 && check_option(varargin,'symmetrise')
    scrPrnt('SubStep','Applying specimen symmetry to PTMC solution');
    nrVars = length(TRIP.vars);
    PTMC{1} = PTMCin;
    PTMC{1}.Trot = TRIP.SymM(:,:,1);
    for i = 2:nrVars
        PTMC{i} = PTMCin;
        PTMC{i}.Trot = TRIP.SymM(:,:,i); %Change from mtex to Bunge convention
        %Rotations according to convention in [J.S. Bowles, J.K. Mackenzie,
        %J.S. Bowles, Acta Metall. 2 (1954) 138–147.]
        PTMC{i}.SP = PTMC{i}.Trot*PTMC{i}.SP';
        PTMC{i}.SD = PTMC{i}.Trot*PTMC{i}.SD;
        PTMC{i}.bTa = PTMC{i}.Trot*PTMC{i}.bTa;
        PTMC{i}.bCa = PTMC{i}.Trot*PTMC{i}.bCa;
        PTMC{i}.M.A = PTMC{i}.Trot*PTMC{i}.M.A*PTMC{i}.Trot';
        PTMC{i}.M.B = PTMC{i}.Trot*PTMC{i}.M.B*PTMC{i}.Trot';
        
        for j = 1:2           
            PTMC{i}.IL.A(:,j) = PTMC{i}.Trot*PTMC{i}.IL.A(:,j);
            PTMC{i}.IL.B(:,j) = PTMC{i}.Trot*PTMC{i}.IL.B(:,j);
            PTMC{i}.IN.A(:,j) = PTMC{i}.Trot*PTMC{i}.IN.A(:,j);
            PTMC{i}.IN.B(:,j) = PTMC{i}.Trot*PTMC{i}.IN.B(:,j);
        end
        for j = 1:4
            PTMC{i}.H.A(:,j) = PTMC{i}.Trot*PTMC{i}.H.A(:,j);
            PTMC{i}.H.B(:,j) = PTMC{i}.Trot*PTMC{i}.H.B(:,j);
            PTMC{i}.d(:,j) = PTMC{i}.Trot*PTMC{i}.d(:,j);
            PTMC{i}.OR(:,:,j) = PTMC{i}.Trot*PTMC{i}.OR(:,:,j)*PTMC{i}.Trot';
            PTMC{i}.F(:,:,j) = PTMC{i}.Trot*PTMC{i}.F(:,:,j)*PTMC{i}.Trot';
            PTMC{i}.PSP(:,:,j) = PTMC{i}.Trot*PTMC{i}.PSP(:,:,j)*PTMC{i}.Trot';
            PTMC{i}.PJP(:,:,j) = PTMC{i}.Trot*PTMC{i}.PJP(:,:,j)*PTMC{i}.Trot';
        end
    end
end

%% Compute Miller
scrPrnt('SubStep','Computing Miller indicees');
nrSol = 4;
for var = 1:length(PTMC) %Loop over variants
    if isa(SDa,'char') && strcmpi(SDa,'twinning')
        PTMC{var}.LIS = 'twinning';
    else
        PTMC{var}.LIS = 'slip';
    end    
    for i = 1:nrSol     %Loop over solutions
            PTMC{var}.Miller.H.A(i) = Miller(PTMC{var}.H.A(1,i),PTMC{var}.H.A(2,i),PTMC{var}.H.A(3,i),CS.A,'hkl');
            PTMC{var}.Miller.H.B(i) = Miller(PTMC{var}.H.B(1,i),PTMC{var}.H.B(2,i),PTMC{var}.H.B(3,i),CS.B,'hkl');
            PTMC{var}.Miller.d(i) = Miller(PTMC{var}.d(1,i),PTMC{var}.d(2,i),PTMC{var}.d(3,i),CS.A,'uvw');
    end
end



