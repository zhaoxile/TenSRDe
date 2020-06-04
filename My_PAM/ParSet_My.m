function  [par]=ParSet_My(nSig)
par.nSig            =   nSig;                              
par.patsize   = 5;
par.patnum  = 200;
par.lamada   =  0.5;
par.theta      =  0.7;
par.rho         =  0.5;
par.gam        =  5;
par.delta       =  3;  
par.MaxIter   = 10; 
par.eps          =  0.1;
par.SearchWin =   30;                                
par.c1              =  5*sqrt(2);                         
par.step           = 4;                                       
par.Out_Iter     =  3;
end
