%%%%%%%%%%%%% Post-Processing %%%%%%%%%%%%%%
%%%% Input %%%%
% Nodes Number: Nnd
% Displacement Matrix: Dv
% DOFs of an element: NdDOFs
% DOF of Displacement: f -> 0; f' -> 1
%%%% Output %%%%
% Displacement: v0 or v1

function Dvi = Post_Process_Dvi(Nnd,Dv,DOF,NdDOFs)
    Dvi = zeros(Nnd,1);
    for i = 1:Nnd
        Idof = NdDOFs*i - NdDOFs + (DOF +1);
        Dvi(i) = Dv(Idof);
    end
end