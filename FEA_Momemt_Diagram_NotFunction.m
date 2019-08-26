%%%%%%%%%%%%% Input %%%%%%%%%%%%%%
% Material(N/m^2): E v
E = 2.0 * 10^11;
vv = 0.3;
G = E / (2 * (1+vv));
% I-Section(mm): h hw bT tT bB tB
h = 300; tw = 8;
bT = 200; tT = 12;
bB = 120; tB = 12;
% Length(m): L
L = 10;
% Elements number: Nel
Nel = 10;
Le = L / Nel;
Nnd = Nel + 1;
% In-plane BCs: v(z) v1(z)
vz0 = [0 10]'; 
vz1 = []'; 
% Loads(kN m)[Ld(Amplitude Distribution)]: qy Py Mx0
qy = []';
Py = [1000 5];
Mx0 = [-5000 0; 5000 10];   


%%%%%%%%%%%%% Element Matrix %%%%%%%%%%%%%%
Ix = Section_Ix(h,tw,bT,tT,bB,tB); % m^4
Ke = E * Ix * Ele_Stiff_Mat_Z22(Le);

%%%%%%%%%%%%% Total Matrix %%%%%%%%%%%%%%
%%% Stiffness Matrix [K](2*Nnd)x(2*Nnd)
KK = zeros(2*Nnd);
for i = 1 : (Nnd - 1)
    KK(2*i-1 : 2*i + 2, 2*i-1 : 2*i + 2) = KK(2*i-1 : 2*i + 2, 2*i-1 : 2*i + 2) + Ke;
end
KK = sparse(KK);
%%% Loads Matrix [QQ](2*Nnd)x(1)
% [Qq](2*Nnd)x(1)
Qq = zeros(2*Nnd,1);
if size(qy) ~= [0 0]    
    qySum = sum(qy);
    for i = 1 : (Nnd - 1)
        Qeq = Ele_Stiff_Mat_qye(Le)';
        Qq(2*i-1 : 2*i + 2) = Qq(2*i-1 : 2*i + 2) + qySum * Qeq;
    end
end
% [QP](2*Nnd)x(1)
QP = zeros(2*Nnd,1);
if size(Py) ~= [0 0]
    PyNd = Py; % Transfer zPy to Element Number of Py
    PyNd(:,2) = floor(Py(:,2)/Le) + 1;     
    for i = 1 : size(Py,1)
        QeP = Ele_Stiff_Mat_Pye(Le,Py(i,2)); % Element Matrix of Py
        QP = Assemble_Concentrated_Loads_Mat(i,Nnd,Py,PyNd,QeP,QP);
    end
end
% [QM](2*Nnd)x(1)
QM = zeros(2*Nnd,1);
if size(Mx0) ~= [0 0]
    Mx0Nd = Mx0; % Transfer zMx0 to Element Number of Mx0
    Mx0Nd(:,2) = floor(Mx0(:,2)/Le) + 1;    
    for i = 1 : size(Mx0,1)
        QeM = Ele_Stiff_Mat_Mxe(Le,Mx0(i,2)); % Element Matrix of Mx0
        QM = Assemble_Concentrated_Loads_Mat(i,Nnd,Mx0,Mx0Nd,QeM,QM);
    end
end
% [QQ](2*Nnd)x(1)
QQ = Qq + QP + QM;

%%%%%%%%%%%%% Total Matrix with BCs %%%%%%%%%%%%%%
Dd0 = 0; % f 
vz0Nd = floor(vz0./Le) + 1; % the Node Num. for BCs
vz0NdDOF = 2 .* vz0Nd - 1; % the Node DOFs Num. for BCs
Dd1 = 1; % f'
vz1Nd = floor(vz1./Le) + 1; % the Node Num. for BCs
vz1NdDOF = 2 .* vz1Nd; % the Node DOFs Num. for BCs
BCsNdDOF = [vz0NdDOF;vz1NdDOF]; % the Node DOFs Num. for all BCs
KKsl = Mat_BCs(KK,BCsNdDOF);
QQsl = Mat_BCs(QQ,BCsNdDOF);

%%%%%%%%%%%%% Solve %%%%%%%%%%%%%%
Dv = Displacement_Mat(KKsl,QQsl,Nnd,BCsNdDOF);
Dv0 = zeros(Nnd,1);
Dv1 = zeros(Nnd,1);
for i = 1:Nnd
    Dv0(i) = Dv(2*i-1);
    Dv1(i) = Dv(2*i);
end

%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
%%% Reforces
RR = KK*Dv - QQ;
%%% Moment
Mx = Post_Process_Mx(Nnd,Le,Dv,E,Ix);
plot(Mx)