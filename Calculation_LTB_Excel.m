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
RPy = ['AH' 'AI' 'AD';'AJ' 'AK' 'AE'];
Rqy = ['' ''];
RM0 = '';

%%%% Rows----numbers of specimens
RWstart = '3';
RWend = '272';
%
%%%%% Write Range %%%%%
%%% Columns
WMcr = 'AP';

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
%%%% qy = [Amp  ay] %%%%
Lqy = cell(Cn,1);
if isempty(Rqy)
    for i = 1 : Cn
        Lqy{i} = zeros(1,2);
    end
else
    Nqy = size(Rqy,1);%Num of loads of each cases
    LqyAmp = zeros(Nqy,Cn);
    Laqy = zeros(Nqy,Cn);
    for i = 1 : Nqy %Num of loads of each groups
        LqyAmp(i,:) = xlsread(Filename,Sheet,[Rqy(i,1:2),RWstart,':',Rqy(i,1:2),RWend]);
        Laqy(i,:) = xlsread(Filename,Sheet,[Rqy(i,3:4),RWstart,':',Rqy(i,3:4),RWend]);
    end
    for i = 1 : Cn % each loads groups
        Lqy{i}(:,1) = LpyAmp(:,i);
        Lqy{i}(:,2) = Lapy(:,i)*1000;
    end
end
%%%% Py = [Amp  z  ay] %%%%
LPy = cell(Cn,1);
if isempty(RPy)
    for i = 1 : Cn
        LPy{i} = zeros(1,3);
    end
else
    NPy = size(RPy,1);%Num of loads of each cases
    LpyAmp = zeros(NPy,Cn);
    Lzpy = zeros(NPy,Cn);
    Lapy = zeros(NPy,Cn);
    for i = 1 : NPy %Num of loads of each groups
        LpyAmp(i,:) = xlsread(Filename,Sheet,[RPy(i,1:2),RWstart,':',RPy(i,1:2),RWend]);
        Lzpy(i,:) = xlsread(Filename,Sheet,[RPy(i,3:4),RWstart,':',RPy(i,3:4),RWend]);
        Lapy(i,:) = xlsread(Filename,Sheet,[RPy(i,5:6),RWstart,':',RPy(i,5:6),RWend]);
    end
    for i = 1 : Cn % each loads groups
        LPy{i}(:,1) = LpyAmp(:,i);
        LPy{i}(:,2) = Lzpy(:,i);
        LPy{i}(:,3) = Lapy(:,i)*1000;
    end
end
%%%% M0 = [Amp  z] %%%%
LM0 = cell(Cn,1);
if isempty(RM0)
    for i = 1 : Cn
        LM0{i} = zeros(1,2);
    end 
else
    NM0 = size(RM0,1);%Num of loads of each cases
    LM0Amp = zeros(NM0,Cn);
    LzM0 = zeros(NM0,Cn);
    for i = 1 : NM0 %Num of loads of each groups
        LM0Amp(i,:) = xlsread(Filename,Sheet,[RM0(i,1:2),RWstart,':',RM0(i,1:2),RWend]);
        LzM0(i,:) = xlsread(Filename,Sheet,[RM0(i,3:4),RWstart,':',RM0(i,3:4),RWend]);
    end
    for i = 1 : Cn % each loads groups
        LM0{i}(:,1) = LM0Amp(:,i);
        LM0{i}(:,2) = LzM0(:,i);
    end
end

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
Mcr = zeros(Cn,1);
parfor  i = 1 : 1 : Cn % parallell calculation
    McrM = FEA_LTB(E(i),vv(i),h(i),tw(i),bT(i),tT(i),bB(i),tB(i),L(i),Nel,vz0,vz1,uz0,uz1,phiz0,phiz1,Lqy{i},LPy{i},LM0{i});% kN m
    Mcr(i) = abs(McrM(1));
end
xlswrite(Filename,Mcr,Sheet,[WMcr,RWstart,':',WMcr,RWend])
toc