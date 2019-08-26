%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le

function Z22 = Ele_Stiff_Mat_Z22(Le)
Z22 = [12/Le^3,  6/Le^2, -12/Le^3,  6/Le^2 ;
        6/Le^2,    4/Le,  -6/Le^2,    2/Le ;
      -12/Le^3, -6/Le^2,  12/Le^3, -6/Le^2 ;
        6/Le^2,    2/Le,  -6/Le^2,    4/Le ];
end