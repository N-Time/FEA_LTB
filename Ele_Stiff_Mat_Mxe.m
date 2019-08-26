%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le zmx

function Mxe = Ele_Stiff_Mat_Mxe(Le,zmx)
a = mod(zmx,Le);
N1 = @(z,Le) [ (6*z^2)/Le^3 - (6*z)/Le^2, (3*z^2)/Le^2 - (4*z)/Le + 1, (6*z)/Le^2 - (6*z^2)/Le^3, (3*z^2)/Le^2 - (2*z)/Le];
Mxe = N1(a,Le);
end