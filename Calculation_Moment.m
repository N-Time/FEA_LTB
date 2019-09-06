%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
% Material(N/m^2): E v
E = 2.0 * 10^11;
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

% Loads(kN m)[Ld(Amplitude Distribution)]: qy Py Mx0
qy = [0]';
%%%% [Amp  z] %%%%
Py = [1 3; 0.5 1.5];%
Mx0 = [0 0];%

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
[Mx, Mxmax, Qy] = FEA_Moment_Diagram(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,qy,Py,Mx0); % N m