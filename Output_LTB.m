%%%%%%%%%%%%% Output %%%%%%%%%%%%%%
    %%% Deflection
    Mcr = McrE(abs(Mx) == min(abs(Mx)));
    DispSl = null(KKLsl + Mcr *  KKGsl, 'r');
    Du0 = Post_Process_Dvi(Nnd,DispSl,1,NdDOFs); % u0
    Post_Process_Plot(L,Le,Du0,'u0','r') 
    Du1 = Post_Process_Dvi(Nnd,DispSl,2,NdDOFs); % u1
    Post_Process_Plot(L,Le,Du1,'u1','r')
    Dphi0 = Post_Process_Dvi(Nnd,DispSl,3,NdDOFs); % phi0
    Post_Process_Plot(L,Le,Dphi0,'phi0','r')
    Dphi1 = Post_Process_Dvi(Nnd,DispSl,4,NdDOFs); % phi1
    Post_Process_Plot(L,Le,Dphi1,'phi1','r')