%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le

function qe = Ele_Stiff_Mat_qye(Le)
qe = [ Le/2, Le^2/12, Le/2, -Le^2/12];
end