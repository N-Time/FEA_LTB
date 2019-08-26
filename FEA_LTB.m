function Mcr = FEA_LTB(E,vv,h,tw,bT,tT,bB,tB,L,Nel,vz0,vz1,uz0,uz1,phiz0,phiz1,qy,Py,Mx0)
    %%% Output
    % Mcr = [Amp z]

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
    Mcr = Mxmax;
end