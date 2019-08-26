%%%%%%%%%%%%% Loads Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Loads: Py = [Amp z]
% Lenth of Element: Le
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
%%%% Output %%%%
% [QP](NdDOFs*Nnd)x(1)

function QP = Load_Mat_Py(Py,Le,Nnd,NdDOFs)
    QP = zeros(2*Nnd,1);
    if Py(:,1) ~= 0 % is not empty matrix (loads exist)
        Py(:,1) = Py(:,1) * 1000; % Transfer the Unity from kN to N
        PyNd = Py; % Transfer zPy to Element Number of Py
        PyNd(:,2) = floor(Py(:,2)/Le) + 1; % Node Number of Py
        for i = 1 : size(Py,1)
            QeP = Ele_Stiff_Mat_Pye(Le,Py(i,2)); % Element Matrix of Py
            QP = Load_Mat_Assemble_Concentrate(i,Nnd,NdDOFs,Py,PyNd,QeP,QP);
        end
    end
end