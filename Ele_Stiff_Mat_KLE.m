%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le
% DOFs of each Node: NdDOFs
% Material: E G
% Geometry: Iy It Iw
%%%% Output %%%%
% [KLE](2*NdDOFs)*(2*NdDOFs)

function KKLE = Ele_Stiff_Mat_KLE(Le,NdDOFs,E,G,Iy,It,Iw)
    Z11 = Ele_Stiff_Mat_Z11(Le);
    Z22 = Ele_Stiff_Mat_Z22(Le);
    KKLe = zeros(2*NdDOFs);
    KKLe(1:NdDOFs,1:NdDOFs) = E * Iy * Z22;
    KKLe(NdDOFs+1:2*NdDOFs, NdDOFs+1:2*NdDOFs) = G * It * Z11 + E * Iw * Z22;
    KKLe([3 4 5 6],:) = KKLe([5 6 3 4],:); % transfer the rows due to the order of displacement
    KKLe(:,[3 4 5 6]) = KKLe(:,[5 6 3 4]); % transfer the columns due to the order of displacement
    KKLE = KKLe;
end