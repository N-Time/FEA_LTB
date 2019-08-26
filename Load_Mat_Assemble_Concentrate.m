%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Nodes: i, Nnd
% Loads: Ld, LdNd
% Element Matrix: MLde
% Loads Matrix: MLd

function MLd = Load_Mat_Assemble_Concentrate(i,Nnd,NdDOFs,Ld,LdNd,MLde,MLd)
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    if LdNd(i,2) == Nnd % For the load at the end of Nodes
        MLd(Igd*LdNd(i,2) - I1 : Igd*LdNd(i,2)) = Ld(i,1) * MLde(1:2);
    else % For the load not at the end of Nodes Igd*i-I1
        MLd(Igd*LdNd(i,2) - I1 : Igd*LdNd(i,2) -I1+I2) = Ld(i,1) * MLde;
    end
end