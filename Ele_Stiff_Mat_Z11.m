%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le

function Z11 = Ele_Stiff_Mat_Z11(Le)
Z11 = [6/(5*Le),      1/10, -6/(5*Le),      1/10 ;
           1/10, (2*Le)/15,     -1/10,    -Le/30 ;
      -6/(5*Le),     -1/10,  6/(5*Le),     -1/10 ;
           1/10,    -Le/30,     -1/10, (2*Le)/15];
end