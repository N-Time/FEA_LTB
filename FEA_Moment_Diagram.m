function [Mx, Mxmax, Qy] = FEA_Moment_Diagram(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,qy,Py,Mx0)
    %%%%%%%%%%%%% Input %%%%%%%%%%%%%%    
    G = E / (2 * (1+vv)); % G
    Le = L / Nel; % Lenth of an element
    Nnd = Nel + 1; % Nodes numbers
    NdDOFs = 2; % Num. of Nodes DOFs [Bending] v v'
    
    %%%%%%%%%%%%% Element Matrix %%%%%%%%%%%%%%
    Ix = Section_Ix(h,tw,bT,tT,bB,tB); % m^4
    Ke = E * Ix * Ele_Stiff_Mat_Z22(Le);

    %%%%%%%%%%%%% Total Matrix %%%%%%%%%%%%%%
    %%% Stiffness Matrix [K](2*Nnd)x(2*Nnd)
    KK = Global_Stiff_Mat(Ke,Nnd,NdDOFs);
    %%% Loads Matrix [QQ](2*Nnd)x(1)
    % [Qq](2*Nnd)x(1)
    Qq = Load_Mat_qy(qy,Le,Nnd,NdDOFs);
    % [QP](2*Nnd)x(1)
    QP = Load_Mat_Py(Py,Le,Nnd,NdDOFs);
    % [QM](2*Nnd)x(1)
    QM = Load_Mat_Mx0(Mx0,Le,Nnd,NdDOFs);
    % [QQ](2*Nnd)x(1)
    QQ = Qq + QP + QM;

    %%%%%%%%%%%%% Total Matrix with BCs %%%%%%%%%%%%%%
    % the Node DOFs Num. for all BCs
    BCsNdDOF = Mat_BCs_NdDOF_Bending(vz0,vz1,Le);
    % [K] and [Q] with BCs for solving
    KKsl = Mat_BCs(KK,BCsNdDOF);
    QQsl = Mat_BCs(QQ,BCsNdDOF);

    %%%%%%%%%%%%% Solve %%%%%%%%%%%%%%
    Dv = Displacement_Mat(KKsl,QQsl,Nnd,BCsNdDOF);
    
    %%%%%%%%%%%%% Post-Processing %%%%%%%%%%%%%%
    %%% Deflection
    Dv0 = Post_Process_Dvi(Nnd,Dv,0,NdDOFs);
    Post_Process_Plot(L,Le,Dv0,'Deflection','r')
    %%% Reforces
    RR = KK*Dv - QQ;
    %%% Moment
    Mx = Post_Process_Inter_Force(Nel,NdDOFs,Ke,Dv,'Mx');
    Post_Process_Plot(L,Le,Mx,'Moment','b')
    Mxmax = Post_Process_PmMax(Mx,Le,'all');
    %%% Shear
    Qy = Post_Process_Inter_Force(Nel,NdDOFs,Ke,Dv,'Qy');
    Post_Process_Plot(L,Le,Qy,'Shear','c')
end