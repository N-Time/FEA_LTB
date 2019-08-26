%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le zpy

function Z00P = Ele_Stiff_Mat_Z00P(Le,zpy)
a = mod(zpy,Le);
b = Le - a;
r0 = b^2 * (3*a + b) / Le^3;
r1 = a^2 * (a + 3 * b) / Le^3;
Z00P = [     r0     0     0     0
              0     0     0     0
              0     0     r1    0
              0     0     0     0  ];
end