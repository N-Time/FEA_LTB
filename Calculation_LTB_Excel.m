tic
%%%%%%%%%%%%% Parallel Setting  %%%%%%%%%%%%%%
Filename = 'C2fin.xlsx';
Sheet = 1;
%
%%%%% Read range %%%%%
%%% Columns
% Profiles
Rh = 'C'; Rtw = 'G'; RbT = 'D'; RtT = 'F'; RbB = 'E'; RtB = 'F';
% Lengthes
RL = 'K';
% Material
RE = 'H'; Rv = 'J';
% Load
% Amp [zpy] ay 
Rqy = ['' ''];
RPy = ['AI' 'AJ' 'AD';'AK' 'AL' 'AE'];
RM0 = '';

%%%% Rows----numbers of specimens
RWstart = '18';
RWend = '137';
%
%%%%% Write Range %%%%%
%%% Columns
WMcr = 'BL';

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
% The numbers of cases of loads
Cn = str2double(RWend) - str2double(RWstart) + 1;
[Lqy,LPy,LM0] = MultiLoads(Filename,Sheet,RWend,RWstart,Cn,Rqy,RPy,RM0);

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
Mcr = zeros(Cn,1);
parfor  i = 1 : 1 : Cn % parallell calculation
    McrM = FEA_LTB(E(i),vv(i),h(i),tw(i),bT(i),tT(i),bB(i),tB(i),L(i),Nel,vz0,vz1,uz0,uz1,phiz0,phiz1,Lqy{i},LPy{i},LM0{i});% kN m
    Mcr(i) = abs(McrM(1));
end
xlswrite(Filename,Mcr,Sheet,[WMcr,RWstart,':',WMcr,RWend])
toc