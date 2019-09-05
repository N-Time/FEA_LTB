%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
%%% Origin Input
% Material(N/m^2): E v
E = 2.1 * 10^11;
vv = 0.3;
% I-Section(mm): h hw bT tT bB tB
h = 300; tw = 7.1;
bT = 150; tT = 10.7;
bB = 150; tB = 10.7;
% Length(m): L
L = 3;
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
%%%% [Amp  ay] %%%%
qy = [0 0];
%%%% [Amp  z  ay] %%%%
Py = [1 3 -150;1 3 150];
%%%% [Amp  z] %%%%
Mx0 = [0 0];   

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
Mcr = FEA_LTB(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,uz0,uz1,phiz0,phiz1,qy,Py,Mx0) % kN m