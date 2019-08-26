%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le

function Z00 = Ele_Stiff_Mat_Z00(Le)
Z00 = [      (13*Le)/35, (11*Le^2)/210,      (9*Le)/70, -(13*Le^2)/420 ;
          (11*Le^2)/210,      Le^3/105,  (13*Le^2)/420,      -Le^3/140 ;
              (9*Le)/70, (13*Le^2)/420,     (13*Le)/35, -(11*Le^2)/210 ;
         -(13*Le^2)/420,     -Le^3/140, -(11*Le^2)/210,       Le^3/105 ];
end