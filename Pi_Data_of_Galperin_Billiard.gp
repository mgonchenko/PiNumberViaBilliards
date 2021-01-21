\\ March 2020
\\ Code to get the coordinates and velocities in the Galperin billiard used to get the digits of pi number
\\

\\==================================
map_billiard_odd(Xn, xn, Vn, vn, M,m)={

Xn1=Xn+(Xn-xn)*Vn/(vn-Vn);
xn1=xn+(Xn-xn)*vn/(vn-Vn);
Vn1=(M-m)/(M+m)*Vn+2*m/(m+M)*vn;
vn1=2*M/(m+M)*Vn+(m-M)/(m+M)*vn;

return([Xn1,xn1,Vn1,vn1]);
}

\\==================================
map_billiard_even(Xn, xn, Vn, vn, M,m)={

Xn2=Xn-Vn*xn/vn;
\\print(Xn2);
xn2=0;
Vn2=Vn;
vn2=-vn;

return([Xn2,xn2,Vn2,vn2]);
}



\\===========MAIN Program===========
{
default(format, "g0.8");

V0=1.; X0=-3.; x0=-1.; v0=0.;

N=1; b=sqrt(3); m=1; M=b^(2*N)*m;

iter=vector(4);

Niter=7;
V=V0; v=v0; X=X0; x=x0; vprev=v0;
t=-(X0-x0)/(v0-V0);\\time
i=0; tau=0; phin=0;

Xmin=sqrt(m/M)*x0;
iter=map_billiard_odd(X, x, V, v, M,m);
t_inv=1.*abs(iter[1])/V0; \\abs(Xmin)/(sqrt(m/M)*V0);
t_inv=sqrt(iter[1]*iter[1]-Xmin*Xmin)/V0;
print("t return ", t_inv);

\\file to write the data
flnm=Strexpand("data_b_sqrt3_N_1.dat");

\\to get billiard data
write(flnm, "# i,  t,  X,  x,  V,  v,  tau");
write(flnm, 0, " ", t, " ", X, " ", x, " ", V, " ", v, " ", tau);

while(X<0,
    i=i+1;
    if(i%2,
       tau=(X-x)/(v-V); 
       t=t+(X-x)/(v-V);
       vprev=v;
       iter=map_billiard_odd(X, x, V, v, M,m);
       print(i, odd, " ", t);
       
       phi2k=phin;
       phin=(-1)^(i+1)*2*atan(1/b^N)*floor(i/2+1/2);
       Vfrml=V0*cos(phin);
       vfrml=V0*b^N*sin(phin);
       Xfrml=-x0/(b^N*sin(phi2k)-cos(phi2k));
       if(abs(phi2k)>0, 
          tauf=x0/(b^N*sin(phi2k)*V0*(cos(phi2k)-b^N*sin(phi2k)));
       );
       X=iter[1]; x=iter[2]; V=iter[3]; v=iter[4];
       write(flnm, i, " ",  t, " ", X, " ", x, " ", V, " ", v, " ", tau);

       if(v<0||abs(v)<1.e-10, 
          print("stopped: v=", v); 
          break();
       );       
    , 
       t=t-x/v; tau=-x/v; vprev=v;
       iter=map_billiard_even(X, x, V, v, M,m);

       phin=(-1)^(i+1)*2*atan(1/b^N)*floor(i/2+1/2);
       phi2k=phin;
       Vfrml=V0*cos(phin);
       vfrml=V0*b^N*sin(phin);
       print("b^N*sin(phi2k)=", b^N*sin(phi2k));
       Xfrml=-x0/(b^N*sin(phi2k));
       
       tauf1=-x0/(b^N*sin(phi2k)*V0*(cos(phi2k)+b^N*sin(phi2k)));
       X=iter[1]; x=iter[2]; V=iter[3]; v=iter[4];
       
       write(flnm, i, " ", t, " ", X, " ", x, " ", V, " ", v, " ", tau);


    );
 
);

}
