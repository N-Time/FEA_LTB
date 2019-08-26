%%%%%%%%%%%%% Matrix with BCs %%%%%%%%%%%%%%
%%%% Input %%%%
% BCs Position: uz0 uz1 phiz0 phiz1
% Lenth of an element: Le

function BCsNdDOF = Mat_BCs_NdDOF_LTB(uz0,uz1,phiz0,phiz1,Le,NdDOFs)
    % u
    uz0Nd = floor(uz0./Le) + 1; % the Node Num. for BCs
    uz0NdDOF = NdDOFs .* uz0Nd - NdDOFs + 1; % the Node DOFs Num. for BCs
    % u'
    uz1Nd = floor(uz1./Le) + 1; % the Node Num. for BCs
    uz1NdDOF = NdDOFs .* uz1Nd - NdDOFs + 2; % the Node DOFs Num. for BCs
    % phi
    phiz0Nd = floor(phiz0./Le) + 1; % the Node Num. for BCs
    phiz0NdDOF = NdDOFs .* phiz0Nd - NdDOFs + 3; % the Node DOFs Num. for BCs
    % phi'
    phiz1Nd = floor(phiz1./Le) + 1; % the Node Num. for BCs
    phiz1NdDOF = NdDOFs .* phiz1Nd - NdDOFs + 4; % the Node DOFs Num. for BCs
    % ALL
    BCsNdDOF = [uz0NdDOF;uz1NdDOF;phiz0NdDOF;phiz1NdDOF]; % the Node DOFs Num. for all BCs
end