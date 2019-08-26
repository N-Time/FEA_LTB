tic
%%%%%%%%%%%%% Parallel Setting  %%%%%%%%%%%%%%
Filename = 'Sample.xlsx';
Sheet = 1;
%
%%%%% Read range %%%%%
%%% Columns
% Profiles
Rh = 'C'; Rtw = 'G'; RbT = 'D'; RtT = 'F'; RbB = 'E'; RtB = 'F';
% Lengthes
RL = 'K';
% Material
RE = 'H'; Rv = 'I';
% Load
% Amp ay 
RPy = ['AF' 'AD'];
Rqy = ['' ''];
RM0 = 'AG';

%%%% Rows----numbers of specimens
RWstart = '3';
RWend = '497';
%
%%%%% Write Range %%%%%
%%% Columns
WMcr = 'AH';

%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
%%% Origin Input
% Material(N/m^2): E v
E = xlsread(Filename,Sheet,[RE,RWstart,':',RE,RWend]); 
vv = xlsread(Filename,Sheet,[Rv,RWstart,':',Rv,RWend]); 
% I-Section(mm): h hw bT tT bB tB
h = xlsread(Filename,Sheet,[Rh,RWstart,':',Rh,RWend]);
tw = xlsread(Filename,Sheet,[Rtw,RWstart,':',Rtw,RWend]);
bT = xlsread(Filename,Sheet,[RbT,RWstart,':',RbT,RWend]); 
tT = xlsread(Filename,Sheet,[RtT,RWstart,':',RtT,RWend]);
bB = xlsread(Filename,Sheet,[RbB,RWstart,':',RbB,RWend]); 
tB = xlsread(Filename,Sheet,[RtB,RWstart,':',RtB,RWend]);
% Length(m): L
L = xlsread(Filename,Sheet,[RL,RWstart,':',RL,RWend]);
% Elements numbers: Nel
Nel = 100;
% In-plane BCs: v(z) v1(z)
vz0 = [0]'; 
vz1 = [0]'; 
% Out-plane BCs: u(z) u1(z) phi(z) phi1(z)
uz0 = [0]'; 
uz1 = [0]'; 
phiz0 = [0]'; 
phiz1 = [0]'; 
% Loads(kN m)[Amplitude(kN m) Distribution(m) ay(mm){up<0, down>0}]: qy Py Mx0
%%%% qy = [Amp  ay] %%%%
if isempty(Rqy)
    qy = zeros(size(E,1),2);  
else
    qyAmp = xlsread(Filename,Sheet,[Rqy(1:2),RWstart,':',Rqy(1:2),RWend]);
    qyay = xlsread(Filename,Sheet,[Rqy(3:4),RWstart,':',Rqy(3:4),RWend]);
    qy = [qyAmp qyay];
end
%%%% Py = [Amp  z  ay] %%%%
if isempty(RPy)
    Py = zeros(size(E,1),3);  
else
    PyAmp = xlsread(Filename,Sheet,[RPy(1:2),RWstart,':',RPy(1:2),RWend]);
    Pyz = L./2;
    Pyay = xlsread(Filename,Sheet,[RPy(3:4),RWstart,':',RPy(3:4),RWend]);
    Py = [PyAmp Pyz Pyay];
end
%%%% M0 = [Amp  z] %%%%
if isempty(RM0)
    Mx0 = zeros(size(E,1),2);  
else
    Mx0Amp = xlsread(Filename,Sheet,[RM0,RWstart,':',RM0,RWend]);
	Mx0z = L;
    Mx0 = [Mx0Amp Mx0z];
end

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
Mcr = zeros(size(E,1),1);
parfor  i = 1 : 1 : size(E,1) % parallell calculation
    McrM = FEA_LTB(E(i),vv(i),h(i),tw(i),bT(i),tT(i),bB(i),tB(i),L(i),Nel,vz0,vz1,uz0,uz1,phiz0,phiz1,qy(i,:),Py(i,:),Mx0(i,:));% kN m
    Mcr(i) = abs(McrM(1));
end
xlswrite(Filename,Mcr,Sheet,[WMcr,RWstart,':',WMcr,RWend])
toc