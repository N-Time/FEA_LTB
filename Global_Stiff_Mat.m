%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Stiffness Matrix of Element: Ke
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
%%%% Output %%%%
% [K](NdDOFs*Nnd)x(NdDOFs*Nnd)

function K = Global_Stiff_Mat(Ke,Nnd,NdDOFs)
    K = zeros(NdDOFs*Nnd);
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    for i = 1 : (Nnd - 1)
        K(Igd*i-I1 : Igd*i-I1+I2, Igd*i-I1 : Igd*i-I1+I2) = K(Igd*i-I1 : Igd*i-I1+I2, Igd*i-I1 : Igd*i-I1+I2) + Ke;
    end
end