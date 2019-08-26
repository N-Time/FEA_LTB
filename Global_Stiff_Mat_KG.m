%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Stiffness Matrix of Element: Ke
% DOFs of each node: NdDOFs
% (1) 2 DOFs for Moment of Slender Beams
% (2) 4 DOFs for LTB of Vlasov's Thin-walled Beams
%%%% Output %%%%
% [K](NdDOFs*Nnd)x(NdDOFs*Nnd)

function K = Global_Stiff_Mat_KG(Le,Nnd,NdDOFs,By,Vy,Me1,qy,Py,L)
    K = zeros(NdDOFs*Nnd);
    Igd = NdDOFs;
    I1 = NdDOFs - 1;
    I2 = 2 * NdDOFs - 1;
    for i = 1 : (Nnd - 1) % Number of element
        KGE = Ele_Stiff_Mat_KGE(Le,NdDOFs,By,Vy(i),Me1(i),qy);
        K(Igd*i-I1 : Igd*i-I1+I2, Igd*i-I1 : Igd*i-I1+I2) = K(Igd*i-I1 : Igd*i-I1+I2, Igd*i-I1 : Igd*i-I1+I2) + KGE;
    end
    % Py
    if size(Py) ~= [0 0] % is not empty matrix (loads exist)
        PyNd = Py;
        for i = 1:size(Py,1)
            if Py(i,2) == L % the end node
                PyNd(i,2) = floor(Py(i,2)/Le); % Node Number of Py
            else % Inter nodes
                PyNd(i,2) = floor(Py(i,2)/Le) + 1; % Node Number of Py
            end
            KGEPy = Ele_Stiff_Mat_KGEPy(Le,NdDOFs,Py(i,:));
            K(Igd*PyNd(i,2)-I1 : Igd*PyNd(i,2)-I1+I2, Igd*PyNd(i,2)-I1 : Igd*PyNd(i,2)-I1+I2) = K(Igd*PyNd(i,2)-I1 : Igd*PyNd(i,2)-I1+I2, Igd*PyNd(i,2)-I1 : Igd*PyNd(i,2)-I1+I2) + KGEPy;
        end
    end
end