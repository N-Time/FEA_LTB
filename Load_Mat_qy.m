%%%%%%%%%%%%% Loads Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Loads: qy
% Lenth of Element: Le
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
%%%% Output %%%%
% [Qq](NdDOFs*Nnd)x(1)

function Qq = Load_Mat_qy(qy,Le,Nnd,NdDOFs)
    Qq = zeros(NdDOFs*Nnd,1);
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    if qy(:,1) ~= 0 % is not empty matrix (loads exist)
        qy(:,1) = qy(:,1) * 1000; % Transfer the Unity from kN to N
        qySum = sum(qy(:,1));
        for i = 1 : (Nnd - 1)
            Qeq = Ele_Stiff_Mat_qye(Le)';
            Qq(Igd*i-I1 : Igd*i-I1+I2) = Qq(Igd*i-I1 : Igd*i-I1+I2) + qySum * Qeq;
        end
    end
end