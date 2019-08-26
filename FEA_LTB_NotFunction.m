%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
%%% Origin Input
% Material(N/m^2): E v
E = 2.1 * 10^11;
vv = 0.3;
% I-Section(mm): h hw bT tT bB tB
h = 300; tw = 8;
bT = 150; tT = 12;
bB = 150; tB = 12;
% Length(m): L
L = 10;
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
qy = [];
%%%% [Amp  z  ay] %%%%
Py = [1 10 -150];
%%%% [Amp  z] %%%%
Mx0 = [];   

%%% Secondery Input
G = E / (2 * (1+vv)); % G
Le = L / Nel; % Lenth of an element
Nnd = Nel + 1; % Nodes numbers
NdDOFs = 4; % Num. of Nodes DOFs [LTB] u u' phi phi'

%%% Moment and Shear Distribution, Mxmax
[Mx, Mxmax] = FEA_Moment(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,qy,Py,Mx0); % N m
Me1 = Mx(1 : Nel);
Me2 = Mx(2 : Nel+1);
Vy = (Me2 - Me1) / Le;

%%%%%%%%%%%%% Geometric Parameters %%%%%%%%%%%%%%
%%% yc = 0 at the section coordinate
ys = Section_Shear(h,tw,bT,tT,bB,tB)*10^-3; % m
Iy = Section_Iy(h,tw,bT,tT,bB,tB)*10^-12; % m^4
It = Section_It(h,tw,bT,tT,bB,tB)*10^-12; % m^4
Iw = Section_Iw(h,tw,bT,tT,bB,tB)*10^-18; % m^6
By = Section_By(h,tw,bT,tT,bB,tB)*10^-3; % m

%%%%%%%%%%%%% Element Matrix %%%%%%%%%%%%%%
KKLE = Ele_Stiff_Mat_KLE(Le,NdDOFs,E,G,Iy,It,Iw);
% KKGE is defined at total matrix

%%%%%%%%%%%%% Total Matrix %%%%%%%%%%%%%%
%%% Stiffness Matrix [K](2*Nnd)x(2*Nnd)
KKL = Global_Stiff_Mat(KKLE,Nnd,NdDOFs);
KKG = Global_Stiff_Mat_KG(Le,Nnd,NdDOFs,By,Vy,Me1,qy,Py,L);

%%%%%%%%%%%%% Total Matrix with BCs %%%%%%%%%%%%%%
% the Node DOFs Num. for all BCs
BCsNdDOF = Mat_BCs_NdDOF_LTB(uz0,uz1,phiz0,phiz1,Le,NdDOFs);
% [K] and [Q] with BCs for solving
KKLsl = Mat_BCs(KKL,BCsNdDOF);
KKGsl = Mat_BCs(KKG,BCsNdDOF);

%%%%%%%%%%%%% Solve %%%%%%%%%%%%%%
[VV, DD] = eig(KKLsl,KKGsl);
DD = diag(DD);
ucr = min(DD(DD>0));
Mxmax(1) = ucr * Mxmax(1) * 10^-3;
Mcr = Mxmax