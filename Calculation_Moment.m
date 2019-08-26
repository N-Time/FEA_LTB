%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
% Material(N/m^2): E v
E = 2.0 * 10^11;
vv = 0.3;

% I-Section(mm): h hw bT tT bB tB
h = 300; tw = 8;
bT = 200; tT = 12;
bB = 120; tB = 12;

% Length(m): L
L = 10;

% Elements numbers: Nel
Nel = 100;

% In-plane BCs: v(z) v1(z)
vz0 = [0 10]'; 
vz1 = []'; 

% Loads(kN m)[Ld(Amplitude Distribution)]: qy Py Mx0
qy = []';
%%%% [Amp  z] %%%%
Py = [1 5];
Mx0 = [-1 0; 1 10];   

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
[Mx, Mxmax, Qy] = FEA_Moment_Diagram(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,qy,Py,Mx0); % N m