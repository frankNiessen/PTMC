function [PTMC] = calcPTMC(SP,SD,IL,IN,M,bTa,bCa,varargin)
%function [ptmc,OR] = calcPTMC(SP,SD,IL,IN,M,bTa,bCa)
%PTMC solution
scrPrnt('SegmentStart','PTMC solution',varargin{:});
k = 0;
for d2 = 1:2 %Solutions for invariant line
   for d1 = 1:2 %Solutions for invariant normal
        k = k+1;                                                           %Increase counter
        l = M^(-1)*IN(:,d2); l = l/norm(l);
        x = M*IL(:,d1); x = x/norm(x);
        a = vrrotvec(IL(:,d1),IN(:,d2)); a = a(1:3)';  
        b = vrrotvec(x,l); b = b(1:3)'; 
        PJP(:,:,k) = [IL(:,d1),IN(:,d2),a]/[x,l,b];                    %Rotation matrix
        % ***********************  Invariant line strain (PSP)
        PSP(:,:,k) = PJP(:,:,k)*M;                                                %Invariant line strain (PSP)       
        H_a(k,:) = SP-SP*PSP(:,:,k)^(-1);                                  %Habit plane crystal A
        H_a(k,:) = H_a(k,:)/norm(H_a(k,:));                                %Normalized Habit plane crystal A
        H_b(k,:) = H_a(k,:)*bCa^(-1);                                       %Habit plane crystal B
        H_b(k,:) = H_b(k,:)/norm(H_b(k,:));                                %Normalized Habit plane crystal B
        d(:,k) = (PSP(:,:,k)*SD-SD)/(H_a(k,:)*SD);                          %Direction of macroscopic shape change
        m2(k) = norm(d(:,k));                                              %Magnitude of macroscopic shape change
        d(:,k) = d(:,k)/m2(k);                                             %Normalize Direction of macroscopic shape change
        y = cross([0 1 0],H_a(k,:));                                         %Get arbitrary vector in habit plane
        d1 = (y'-inv(PSP(:,:,k))*y')/(SP*inv(PSP(:,:,k))*y');              %Direction of LIS 
        m1(k) = norm(d1);                                                  %Magnitude of LIS
        alpha(k) = atand(m2(k)/2);                                         %Shear angle [°]
        OR(:,:,k) = bTa*M*PSP(:,:,k)^(-1);                                 %Orientation Relationship matrix
        F(:,:,k) = eye(3) + m2(k)*d(:,k)*H_a(k,:);                         %Macroscopic deformation matrix
   end
end
%% Screen Output
%pSp
scrPrnt('Step','Phase transformation matrix pSp',varargin{:});
for i = 1:4
    scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',PSP(1,:,i),PSP(2,:,i),PSP(3,:,i)),sprintf('_(pSp%i)',i)],varargin{:});
end
%OR
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Orientation matrix A -> B',varargin{:});
for i = 1:4
    scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',OR(1,:,i),OR(2,:,i),OR(3,:,i)),sprintf('_(OR%i)',i)],varargin{:});
end
%H
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Habit plane H',varargin{:});
for i = 1:4
    scrPrnt('SubStep',sprintf('(%.4f %.4f %.4f)_(A%i)',H_a(i,:),i),varargin{:});
end
%d
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Direction of macroscopic shape change d',varargin{:});
for i = 1:4
    scrPrnt('SubStep',sprintf('(%.4f %.4f %.4f)_(A%i)',d(:,i),i),varargin{:});
end

%m2
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Magnitude of macroscopic shape change m2',varargin{:});
scrPrnt('SubStep',sprintf('m2_1: %.4f; m2_2: %.4f; m2_3: %.4f; m2_4: %.4f;',m2),varargin{:});
%OR
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Macroscopic shape deformation matrix F',varargin{:});
for i = 1:4
    scrPrnt('Matrix',[sprintf('\n\t%.4f %.4f %.4f',F(1,:,i),F(2,:,i),F(3,:,i)),sprintf('_(F%i)',i)],varargin{:});
end
%m1
if ~check_option(varargin,'silent'); fprintf('\n'); end
scrPrnt('Step','Magnitude of lattice invariant shear m1',varargin{:});
scrPrnt('SubStep',sprintf('m1_1: %.4f; m1_2: %.4f; m1_3: %.4f; m1_4: %.4f;',m1),varargin{:});

%% Prepare output structure
PTMC.PSP = PSP;
PTMC.H.A = H_a';
PTMC.H.B = H_b';
PTMC.d = d;
PTMC.m2 = m2;
PTMC.m1 = m1;
PTMC.IL = IL;
PTMC.IN = IN;
PTMC.SP = SP;
PTMC.SD = SD;
PTMC.OR = OR;
PTMC.F = F;
PTMC.bTa = bTa;
PTMC.bCa = bCa;
PTMC.PJP = PJP;
end