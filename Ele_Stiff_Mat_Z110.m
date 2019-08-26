%%%%%%%%%%%%% Stiffness Matrix %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le Vy Me1

function Z110 = Ele_Stiff_Mat_Z110(Le,Vy,Me1)
Z110 = [  (3*Vy)/5 + (6*Me1)/(5*Le),      Me1/10 + (Le*Vy)/10, - (3*Vy)/5 - (6*Me1)/(5*Le),                    Me1/10 ;
                Me1/10 + (Le*Vy)/10,  (Le*(4*Me1 + Le*Vy))/30,       - Me1/10 - (Le*Vy)/10,  -(Le*(2*Me1 + Le*Vy))/60 ;
        - (3*Vy)/5 - (6*Me1)/(5*Le),    - Me1/10 - (Le*Vy)/10,   (3*Vy)/5 + (6*Me1)/(5*Le),                   -Me1/10 ;
                             Me1/10, -(Le*(2*Me1 + Le*Vy))/60,                     -Me1/10, (Le*(4*Me1 + 3*Le*Vy))/30 ];
end