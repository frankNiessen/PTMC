% *************************************************************************
% Phenomenological Theory of Martensite (PTMC)
% *************************************************************************
% Dr. Frank Niessen, University of Wollongong, EMC , 04/2020
% contactnospam@fniessen.com (remove 'nospam' to activate this email
% address)
% -------------------------------------------------------------------------
% Implementation of the classical PTMC analysis for any feasible 
% combination of parent and daughter pahse, according to 
% [J.S. Bowles, J.K. Mackenzie, Acta Metall. 2 (1954) 138–147]
% ------------------------------------------------------------------------- 
% Dr. Xinfu Gu, University of Science and Technology Beijing, is
% acknowledged for his support in the development of this program
% ------------------------------------------------------------------------- 
% The execution of this program requires installation of MTEX
% [https://mtex-toolbox.github.io]
% ------------------------------------------------------------------------- 
% A license file is provided in the root directory of the program
% ------------------------------------------------------------------------- 
%% Startup
home; close all; clear variables;
currentFolder;
scrPrnt('StartUp','PTMC analysis');
try 
    startup_mtex % Startup m-tex
catch ME
    warning('You may not have MTEX properly installed');
    rethrow(ME);
end                                     
%% Defining crystal structures
scrPrnt('SegmentStart','Initialization');
% Load parent crystal structure
cif.A = uigetfile('*.cif','Define parent crystal structure',...
                  [fileparts(mfilename('fullpath')),'\data\input\cifs\']);
CS.A = loadCIF(cif.A);
% Load daughter crystal structure
cif.B = uigetfile('*.cif','Define daughter crystal structure',...
                  [fileparts(mfilename('fullpath')),'\data\input\cifs\']);
CS.B = loadCIF(cif.B);
%% Defining lattice correspondance
bCaIni = def_bCa(CS);
while 1
    x = inputdlg({'3x3 matrix: Daughter -> Parent (bCa)'},...
                  'Lattice correspondance matrix', [5 70],...
                  {num2str(bCaIni)});
    if length(x)==0; error('Program terminated by user'); end
    bCa = str2num(x{1});
    if ~isempty(bCa)&& all(size(bCa)==3); break; end
    f = warndlg('Insert a 3x3 numeric matrix','Warning');
    uiwait(f);
end
%% Defining lattice invariant shear (LIS)
%LIS mode
LISmode = questdlg('Which lattice invariant shear (LIS) is assumed?', ...
                   'LIS definition', ...
                   'Twinning LIS','Dislocation Slip LIS','Twinning LIS');
%LIS plane
while 1
    x = inputdlg({'h k l'},'LIS plane - Crystal basis A', [1 70]);
    if length(x)==0; error('Program terminated by user'); end
    SPa = str2num(x{1});
    if ~isempty(SPa)&& length(SPa)==3; break; end
    f = warndlg('Insert 3 numeric values','Warning');
    uiwait(f);
end
SPa = reshape(SPa,3,1);
%LIS direction
if strcmp(LISmode,'Dislocation Slip LIS')
    while 1
        x = inputdlg({'u v w'},'LIS direction - Crystal basis A', [1 70]);
        if length(x)==0; error('Program terminated by user'); end
        SDa = str2num(x{1});
        if ~isempty(SDa)&& length(SDa)==3; break; end
        f = warndlg('Insert 3 numeric values','Warning');
        uiwait(f);
    end
    SDa = reshape(SDa,3,1);
else
    SDa = 'twinning';
end               
%% Perform PTMC calculation            
PTMC = mainPTMC(CS.A,CS.B,SPa,SDa,bCa);
%% Computing OR
scrPrnt('SegmentStart','Computing orientation relationship');
% Get OR symmetry matrices
OR.OR = orientation('Matrix',PTMC.OR(:,:,4),CS.A,CS.B);
scrPrnt('Step',sprintf('OR-Euler angles: [%.2f %.2f %.2f]°',...
        OR.OR.phi1/degree, OR.OR.Phi/degree, OR.OR.phi2/degree));
% Compute variants
OR.vars = unique(orientation.cube(CS.A).symmetrise*inv(OR.OR));
OR.SymRot = OR.vars(1)*inv(OR.vars);
OR.SymM = OR.SymRot.matrix;
scrPrnt('Step',sprintf('Defining %.0f orientation variants',length(OR.vars)));
%% Compute equivalent PTMC solutions of variants
PTMC = analyzePTMC(PTMC,SDa,CS,OR,'symmetrise');                           %Compute equivalent PTMC solutions of all daughter variants
%% Plotting habit planes and directions of macroscopic shear
scrPrnt('SegmentStart','Plotting PTMC results');
% Plot variants
h.D = [Miller(0,0,1,CS.B),Miller(1,1,0,CS.B),Miller(1,1,1,CS.B)];          %Define poles for plotting of daughter variants
plotPDF(OR.vars,h.D,'marker','o','MarkerSize',4,'MarkerFaceColor','white',...
            'MarkerEdgeColor',[0 0 0],'LineWidth',2,'MarkerColor','white');%Plotting daughter variants in pole figure
set(gcf,'name',sprintf('Pole figures of all %d daughter variants',length(OR.vars)));
drawnow;
% Plot habit planes of daughter variants in daughter basis
scrPrnt('Step','Plotting habit planes of daughter variants in daughter basis');
nrSol = length(PTMC{1}.Miller.H.B);
figure;
mtexFig(1) = newMtexFigure('layout',[1,nrSol]);
for solNr = 1:nrSol
    for ii = 1:length(PTMC)
       plot(PTMC{ii}.Miller.H.B(solNr),'antipodal','marker','o','MarkerSize',4,'MarkerFaceColor','white',...
                'MarkerEdgeColor',[0 0 0],'LineWidth',2,'MarkerColor','white');%Plotting daughter variants in pole figure
       hold on    
    end
    nextAxis
end
set(gcf,'name',sprintf('Habit planes in daughter basis of PTMC solutions 1 to %d',nrSol));
drawnow;
% Plot habit planes of daughter variants in parent basis
scrPrnt('Step','Plotting habit planes of daughter variants in parent basis');
nrSol = length(PTMC{1}.Miller.H.A);
figure;
mtexFig(2) = newMtexFigure('layout',[1,nrSol]);
for solNr = 1:nrSol
    for ii = 1:length(PTMC)
       plot(PTMC{ii}.Miller.H.A(solNr),'antipodal','marker','o','MarkerSize',4,'MarkerFaceColor','white',...
                'MarkerEdgeColor',[0 0 0],'LineWidth',2,'MarkerColor','white');%Plotting daughter variants in pole figure
       hold on    
    end
    nextAxis
end
set(gcf,'name',sprintf('Habit planes in parent basis of PTMC solutions 1 to %d',nrSol));
drawnow;
% Plot directions of macroscopic deformation in parent basis
scrPrnt('Step','Plotting directions of macroscopic deformation in parent basis');
nrSol = length(PTMC{1}.Miller.d);
figure;
mtexFig(2) = newMtexFigure('layout',[1,nrSol]);
for solNr = 1:nrSol
    for ii = 1:length(PTMC)
       plot(PTMC{ii}.Miller.d(solNr),'antipodal','marker','o','MarkerSize',4,'MarkerFaceColor','white',...
                'MarkerEdgeColor',[0 0 0],'LineWidth',2,'MarkerColor','white');%Plotting daughter variants in pole figure
       hold on    
    end
    nextAxis
end
set(gcf,'name',sprintf('Directions of macroscopic shear in parent basis of PTMC solutions 1 to %d',nrSol));
drawnow;
% Plot shape deformation
answer = questdlg('Do you want to plot the shape strain and Bain strain in the specimen coordinate system? This might take a while.', ...
                   'Plotting choice', ...
                   'Yes','No','Yes');              
if strcmp(answer,'Yes')
    %LIS plane
    while 1
        opts.Interpreter = 'tex';
        x = inputdlg({'[\phi1 \Phi \phi2]'},'Define parent orientation in Bunge Euler angles [°]', [1 70],{'0 0 0'},opts);
        if length(x)==0; error('Program terminated by user'); end
        EulerAng = str2num(x{1});
        if ~isempty(EulerAng)&& length(EulerAng)==3; break; end
        f = warndlg('Insert 3 numeric values','Warning');
        uiwait(f);
    end
    R = rotation('Euler',EulerAng*degree);
    %PTMC shape strain for all variants and solutions
    scrPrnt('Step','Plotting the shape strain in the specimen coordinate system');
    facs = find((mod(length(PTMC),(1: length(PTMC))))==0);
    [~,ind]=min(abs(facs./sqrt(24)-1));
    layout = sort([facs(ind),length(PTMC)/facs(ind)]);
    for solNr = 1:nrSol
        figure;
        mtexFigs(solNr) = newMtexFigure('layout',layout);
        for ii = 1:length(PTMC)
            F = tensor(PTMC{ii}.F(:,:,solNr)-eye(3),'rank',2,'propertyname','Shape Deformation');
            F = rotate(F,inv(R));
            plot(F,'smooth','antipodal');
            hold on
            annotate(-xvector,'label',sprintf('V%d',ii),'parent',gca);
            if ii~= length(PTMC); nextAxis; end
        end
        annotate(xvector,'label','X',gca);
        annotate(yvector,'label','Y',gca);
        annotate(zvector,'label','Z',gca);
        mtexColorbar('title','Shape strain [1]');   
        set(gcf,'name',sprintf('Shape strain of the %d variants of solution %d',length(PTMC),solNr));
        set(gcf,'units','normalized','outerposition',[0.1 0.1 0.8 0.8]);
        drawnow;
    end
    %Bain strain for all variants
    scrPrnt('Step','Plotting the Bain strain in the specimen coordinate system');
    figure;
    mtexFigsBain = newMtexFigure('layout',layout);
    for ii = 1:length(PTMC)
        B = tensor(PTMC{ii}.M.A-eye(3),'rank',2,'propertyname','Bain Deformation');
        B = rotate(B,inv(R));
        plot(B,'smooth','antipodal');
        hold on 
        annotate(-xvector,'label',sprintf('V%d',ii),'parent',gca);
        if ii~= length(PTMC); nextAxis; end      
    end
    annotate(xvector,'label','X',gca);
    annotate(yvector,'label','Y',gca);
    annotate(zvector,'label','Z',gca);
    mtexColorbar('title','Bain strain [1]'); 
    set(gcf,'name',sprintf('Bain strain of the %d variants',length(PTMC)));
    set(gcf,'units','normalized','outerposition',[0.1 0.1 0.8 0.8]);
    drawnow;
end
scrPrnt('Termination','All done!');