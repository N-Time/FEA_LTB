%%%%%%%%%%%%% Post-Processing %%%%%%%%%%%%%%
%%%% Input %%%%
% Length of an element: Le
% Parameter: Pm
%%%% Output %%%%
% Parameter and its position: [Mxmax, zmaxMx]

function Mxmax = Post_Process_PmMax(Mx,Le,type)
    if strcmp(type,'all')
        Mxmax = [Mx(abs(Mx) == max(abs(Mx))), (find(abs(Mx) == max(abs(Mx)))-1)*Le];
    elseif strcmp(type,'positive')
        Mxmax = [Mx(Mx == max(Mx)), (find(Mx == max(Mx))-1)*Le];
    elseif strcmp(type,'negetive')
        Mxmax = [Mx(Mx == min(Mx)), (find(Mx == min(Mx))-1)*Le];
end