%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Nodes: i, Nnd
% Loads: Ld, LdNd
% Element Matrix: MLde
% Loads Matrix: MLd

function MLd = Load_Mat_Assemble_Concentrate(Nnd,NdDOFs,LdNd,MLde)
    MLd = zeros(NdDOFs*Nnd,1);
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    if LdNd(1,2) == Nnd % For the load at the end of Nodes
        MLd(Igd*LdNd(1,2) - I1 : Igd*LdNd(1,2)) = LdNd(1,1) * MLde(1:2);
    else % For the load not at the end of Nodes Igd*i-I1
        MLd(Igd*LdNd(1,2) - I1 : Igd*LdNd(1,2) -I1+I2) = LdNd(1,1) * MLde;
    end
end