%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le
% DOFs of each Node: NdDOFs
% Geometry: By
% Moment and shear: Me1 Vy
% Uniform loads: qy
%%%% Output %%%%
% [KGE](2*NdDOFs)*(2*NdDOFs)

function KKGE = Ele_Stiff_Mat_KGE(Le,NdDOFs,By,Vy,Me1,qy)
    Z110 = Ele_Stiff_Mat_Z110(Le,Vy,Me1);
    Z011 = Ele_Stiff_Mat_Z011(Le,Vy);
    Z101 = Z011.';
    Z00 = Ele_Stiff_Mat_Z00(Le);
    % qy
    if size(qy) ~= [0 0] % is not empty matrix (loads exist)
        qy(:,1) = qy(:,1) * 1000; % kN to N
        qy(:,2) = qy(:,2) * 0.001; % mm to m
        Sqy = sum(qy(:,1) .* qy(:,2));
    else
        Sqy = 0;
    end
    KKGe = zeros(2*NdDOFs);
    KKGe(1 : NdDOFs, NdDOFs+1 : 2*NdDOFs) = -Z110 -Z101;
    KKGe(NdDOFs+1 : 2*NdDOFs, 1 : NdDOFs) = -Z110 -Z011;
    KKGe(NdDOFs+1 : 2*NdDOFs, NdDOFs+1 : 2*NdDOFs) = - 2*By*Z110 - Sqy*Z00;
    KKGe([3 4 5 6],:) = KKGe([5 6 3 4],:); % transfer the rows due to the order of displacement
    KKGe(:,[3 4 5 6]) = KKGe(:,[5 6 3 4]); % transfer the columns due to the order of displacement
    KKGE = KKGe;
end