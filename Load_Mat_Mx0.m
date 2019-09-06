%%%%%%%%%%%%% Loads Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Loads: Mx0 = [Amp z]
% Lenth of Element: Le
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
%%%% Output %%%%
% [QM](NdDOFs*Nnd)x(1)

function QM = Load_Mat_Mx0(Mx0,Le,Nnd,NdDOFs)
    QM = zeros(2*Nnd,1);
    if Mx0(:,1) ~= 0 % is not empty matrix (loads exist)
        Mx0(:,1) = Mx0(:,1) * 1000; % Transfer the Unity from kN to N
        Mx0Nd = Mx0; % Transfer zMx0 to Element Number of Mx0
        Mx0Nd(:,2) = floor(Mx0(:,2)/Le) + 1; % Node Number of Mx0
        for i = 1 : size(Mx0,1)
            QeM = Ele_Stiff_Mat_Mxe(Le,Mx0(i,2)); % Element Matrix of Mx0
            QM = Load_Mat_Assemble_Concentrate(Nnd,NdDOFs,Mx0Nd(i,:),QeM) + QM;
        end
    end
end