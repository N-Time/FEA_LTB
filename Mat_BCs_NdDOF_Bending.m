%%%%%%%%%%%%% Matrix with BCs %%%%%%%%%%%%%%
%%%% Input %%%%
% BCs Position: vz0 vz1
% Lenth of an element: Le

function BCsNdDOF = Mat_BCs_NdDOF_Bending(vz0,vz1,Le)
    % f
    vz0Nd = floor(vz0./Le) + 1; % the Node Num. for BCs
    vz0NdDOF = 2 .* vz0Nd - 1; % the Node DOFs Num. for BCs
    % f'
    vz1Nd = floor(vz1./Le) + 1; % the Node Num. for BCs
    vz1NdDOF = 2 .* vz1Nd; % the Node DOFs Num. for BCs
    
    BCsNdDOF = [vz0NdDOF;vz1NdDOF]; % the Node DOFs Num. for all BCs
end