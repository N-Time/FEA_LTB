%%%%%%%%%%%%% Solver of Matrix with BCs %%%%%%%%%%%%%%
%%%% Input %%%%
% Stiffness Matrix for Solver: Ksl
% Loads Matrix for Solver: Qsl
% DOFs of all BCs Nodes: BCsNdDOF
% Nodes Number: Nnd

function MD = Displacement_Mat(Ksl,Qsl,Nnd,BCsNdDOF)
MDsl = Ksl \ Qsl;
MD = zeros(2*Nnd,1);
NotBCs = [];
BCsNdDOF = sort(BCsNdDOF);
for i = 1:size(MD,1)
    if i ~= BCsNdDOF
        NotBCs = [NotBCs; i];
    end
end
MD(NotBCs) = MDsl;
end