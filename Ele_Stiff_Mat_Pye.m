%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le zpy

function Pye = Ele_Stiff_Mat_Pye(Le,zpy)
a = mod(zpy,Le);
N0 = @(z,Le) [ (2*z^3)/Le^3 - (3*z^2)/Le^2 + 1, z - (2*z^2)/Le + z^3/Le^2, (3*z^2)/Le^2 - (2*z^3)/Le^3, z^3/Le^2 - z^2/Le];
Pye = N0(a,Le);
end