function [C,P,LIS,OR,bCa] = ini(paramName)
switch lower(paramName)
    %% Wayman 
    case 'wayman'
        %[C.M. Wayman, Introduction to the Crystallography of Martensitic
        %Transformations, 1st ed., The Macmillan Company, New York, 1964.]
        scrPrnt('Step',sprintf('Reading in Initialization parameter set ''%s''',paramName));
        C.abc = [2.875; 2.875; 2.875];                                       %Child lattice parameter [Å]
        C.CS = 'bcc';                                                      %Child crystal structure
        P.abc = [3.591; 3.591; 3.591];                                       %Parent lattice parameter [Å]
        P.CS = 'fcc';                                                      %Parent crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = [1; 0; -1];                                                 %LIS-direction
        OR.uvw.A = [-1; 0; 1];                                               %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 1];                                                %Closed packed plane in parent crystal
        bCa = [1 -1 0; 1 1 0; 0 0 1];                                      %Lattice correspondance matrix
    %% Chai
    case 'chai'
        %[Y.W. Chai, H.Y. Kim, H. Hosoda, S. Miyazaki, Acta Mater. 57 (2009)
        %4054–4064.]
        scrPrnt('Step',sprintf('Reading in Initialization parameter set ''%s''',paramName));
        P.abc = [3.28505; 3.28505; 3.28505];                                 %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [3.1257; 4.8704; 4.6456];                                    %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     %% Davis
    case 'davis'
        %R. Davis, H.M. Flower, D.R.F. West, J. Mater. Sci. 14 (1979) 712–722.
        scrPrnt('Step',sprintf('Reading in Initialization parameter set ''%s''',paramName));
        P.abc = [3.272; 3.272; 3.272];                                       %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [2.994; 4.99; 4.644];                                        %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     %% Duerig
    case 'duerig'
        %[T.W. Duerig, J. Albrecht, D. Richter, P. Fischer, Acta Metall. 30
        %(1982) 2161–2172.]
        scrPrnt('Step',sprintf('Reading in Initialization parameter set ''%s''',paramName));
        P.abc = [3.24; 3.24; 3.24];                                          %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [3.01; 4.91; 4.63];                                          %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     %% Lieberman
    case 'lieberman'
        %[D.S. Lieberman, M.S. Wechsler, T.A. Read, J. Appl. Phys. 26]
        %(1955) 473–484.]
        scrPrnt('Step',sprintf('Reading in Initialization parameter set ''%s''',paramName));     
        P.abc = [3.3165; 3.3165; 3.3165];                                    %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [3.1476; 4.75491; 4.8546];                                   %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     %% Kennon
    case 'kennon'      
        %[1] N.F. Kennon, J.S. Bowlest, Acta Metall. 17 (1969) 373–380.]
        P.abc = [2.9810; 2.9810; 2.9810];                                    %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [2.685; 4.554; 4.342];                                       %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     %% Bowles
    case ' bowles'
        %[J. Bowles, J. Mackenzie, Acta Metall. 5 (1957) 137–149.]
        P.abc = [3.1610; 3.1610; 3.161055];                                  %Parent crystal lattice parameters
        P.CS  = 'bcc';                                                     %Parent crystal structure
        C.abc = [3; 4.7574; 4.5640];                                         %Child crystal lattice parameters
        C.CS  = 'orthorhombic';                                            %Child crystal structure
        LIS.SP.A = [1; 0; 1];                                                  %LIS-plane
        LIS.SD.A = 'twinning';                                               %LIS-direction
        OR.uvw.A = [1; 1; 1];                                                %Closed packed direction in parent crystal
        OR.hkl.A = [1; 1; 0];                                                %Closed packed plane in parent crystal
        bCa = [1 0 0; 0 0.5 -0.5; 0 0.5 0.5];                              %Lattice correspondance matrix
     otherwise
        C = [];P = []; LIS = []; OR = []; bCa = [];
        return
end
 