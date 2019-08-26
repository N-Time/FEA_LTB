%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le
% DOFs of each Node: NdDOFs
% Concentrated loads: Py
%%%% Output %%%%
% [KGEPy](2*NdDOFs)*(2*NdDOFs)

function KKGE = Ele_Stiff_Mat_KGEPy(Le,NdDOFs,Py)
    Py(1) = Py(1) * 1000; % kN to N
    Py(3) = Py(3) * 0.001; % mm to m
    SPy = - 1 / Le * Py(1) * Py(3) * Ele_Stiff_Mat_ZPy(Le,Py(2));
    KKGe = zeros(2*NdDOFs);
    KKGe(NdDOFs+1 : 2*NdDOFs, NdDOFs+1 : 2*NdDOFs) = SPy;
    KKGe([3 4 5 6],:) = KKGe([5 6 3 4],:); % transfer the rows due to the order of displacement
    KKGe(:,[3 4 5 6]) = KKGe(:,[5 6 3 4]); % transfer the columns due to the order of displacement
    KKGE = KKGe;
end