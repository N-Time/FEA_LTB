%%%%%%%%%%%%% Post-Processing %%%%%%%%%%%%%%
%%%% Input %%%%
% Element Number: Nel
% Stiffness Matrix of Element: Ke
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
% Displacement Matrix: Dv
% IForce: 'Qy' or 'Mx'
%%%% Output %%%%
% Shear or Moment Distribution: FI

function FI = Post_Process_Inter_Force(Nel,NdDOFs,Ke,Dv,IForce)
    if strcmp(IForce,'Qy')
        IFn = 1;
    elseif strcmp(IForce,'Mx')
        IFn = 2;
    end
    Nnd = Nel + 1;
    FI = zeros(Nnd,1);
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    for i = 1 : Nel
        Fe = Ke * Dv(Igd*i-I1 : Igd*i-I1+I2);
        FI(i) = Fe(IFn);
    end
    FI(Nnd) = -Fe(IFn+2);
end