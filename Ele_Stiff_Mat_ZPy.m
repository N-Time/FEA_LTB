%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le zpy

function ZPy = Ele_Stiff_Mat_ZPy(Le,zpy)
zp = mod(zpy,Le);
ZPy = [     (Le*((2*zp^3)/Le^3 - (3*zp^2)/Le^2 + 1))/2,     (Le*(zp - (2*zp^2)/Le + zp^3/Le^2))/2,     (Le*((3*zp^2)/Le^2 - (2*zp^3)/Le^3))/2,    -(Le*(zp^2/Le - zp^3/Le^2))/2 ;
         (Le^2*((2*zp^3)/Le^3 - (3*zp^2)/Le^2 + 1))/12,  (Le^2*(zp - (2*zp^2)/Le + zp^3/Le^2))/12,  (Le^2*((3*zp^2)/Le^2 - (2*zp^3)/Le^3))/12, -(Le^2*(zp^2/Le - zp^3/Le^2))/12 ;
            (Le*((2*zp^3)/Le^3 - (3*zp^2)/Le^2 + 1))/2,     (Le*(zp - (2*zp^2)/Le + zp^3/Le^2))/2,     (Le*((3*zp^2)/Le^2 - (2*zp^3)/Le^3))/2,    -(Le*(zp^2/Le - zp^3/Le^2))/2 ;
        -(Le^2*((2*zp^3)/Le^3 - (3*zp^2)/Le^2 + 1))/12, -(Le^2*(zp - (2*zp^2)/Le + zp^3/Le^2))/12, -(Le^2*((3*zp^2)/Le^2 - (2*zp^3)/Le^3))/12,  (Le^2*(zp^2/Le - zp^3/Le^2))/12];
end