%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le Vy

function Z011 = Ele_Stiff_Mat_Z011(Le,Vy)
Z011 = [       -Vy/2,   (Le*Vy)/10,        Vy/2,   -(Le*Vy)/10 ;
         -(Le*Vy)/10,            0,  (Le*Vy)/10, -(Le^2*Vy)/60 ;
               -Vy/2,  -(Le*Vy)/10,        Vy/2,    (Le*Vy)/10 ;
          (Le*Vy)/10, (Le^2*Vy)/60, -(Le*Vy)/10,             0 ];
end