%%%%%%%%%%%%% Post-Processing %%%%%%%%%%%%%%
%%%% Input %%%%
% Nodes Number: Nnd
% Length of an element: Le
% Parameter: Pm
%%%% Output %%%%
% Parameter Distribution: Mx

function Post_Process_Plot(L,Le,Pm,nm,Color)
    zz = 0 : Le : L;
    BeamLine = zeros(size(zz,2),1);
    figure('Name',nm)
    plot(zz,Pm,Color,'LineWidth',1)
    hold on
    plot(zz,BeamLine,'k','LineWidth',2)
    set(gca,'YDir','reverse') % Reversing the Y axis
end