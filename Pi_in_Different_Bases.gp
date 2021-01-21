number_presentation(A, b, Precis)={

\\ Function to give the representation of number A in base b.
\\
\\ Input data:
\\    A=the number in base 10
\\    b=the new base
\\    Precis=precision (number of digits after ".")
\\
\\ Output data:
\\    pi10


k=floor(log(A)/log(b)+1/10^50); 

dk=vector(k+Precis+1);

dk[1]=floor(A/b^k+1/10^50); 
rk=frac(A/b^k);

i2=1;

forstep(i1=k-1, -Precis, -1, 
       i2=i2+1;
       dk[i2]=floor(b*rk+1/10^50);
       rk=frac(b*rk);
);
 
pi10=0;

for(i3=1, length(dk),
    pi10=pi10+dk[i3]*b^(k-i3+1);
);
    
return(pi10);

}

other_representation(A, b, Precis)={

k=floor(log(A)/log(b)+1/10^Precis); 


print(k, " ", Precis);
ak=vector(k+Precis+1);
\\print(A);
rn=A; 
powb=1; i2=0;
while(i2<k+Precis+1, 
   
       i2=i2+1;
       
   
       \\powb=powb/b;
       ak[i2]=floor(rn/b^(k+1-i2)+1/10^Precis);
       \\print(i2, " ", rn, " ", ak[i2]);
       
   
       rn=rn-ak[i2]*b^(k+1-i2);
\\   
       \\print(i2, " d[", i1,"]= ", dk[i2], "r[",i1,"]= " rk);

);
 

print1(A, " \& ");

pi10=0;

for(i3=1, length(dk),

    print1(ak[i3]);

    if(i3==k+1, if(k==-1, print1("0."); ,print1(".");););

    pi10=pi10+ak[i3]*b^(k-i3+1);

);
    
print1(" ");
    
print(pi10);


return(pi10);


}

present_pi_base_b(b, Precis)={

EPS=1/10^50;
print("b= ", b);
for(i=0,10,

    PiPi=floor(Pi/atan(b^(-i))+EPS);

    PiPi1=floor(Pi/b^(-i)+EPS);
    PiPi_div=PiPi*(b^(-i));

    PiPi_div1=PiPi1*(b^(-i));




    print1("arctg:   ", i, " \& ");
    
    pipi10=number_presentation(PiPi, b, i);
    pipi10d=number_presentation(PiPi_div, b, i);

    print1("no arctg ", i, " \& ");
    pipi10=number_presentation(PiPi1, b, i); 
    pipi10dd=number_presentation(PiPi_div1, b, i);   
    \\pipi11=number_presentation(5, b, i);
    
   \\ print("errors:", PiPi_div-Pi, " ",atan(b^(-i)), " ", b^(-i));


);



}

find_b_w_diff_int_parts()={

print("find b with different integer parts");
b=5.72547; h=0.000001; 
while(b<10,
     b=b+h; Ndiff=0;
     intpart1prev=0; intpart2prev=0;
     \\print(b);
     for(N=1, 10,
        intpart1=floor(Pi/atan(b^(-N))+1/10^50);
        intpart2=floor(Pi*b^(N)+1/10^50);
        if(intpart1>intpart2,
           Ndiff=Ndiff+1;
/*           if(Ndiff>1,
             
             if(Ndiff<3, \\Ndiff=2
                print("--------");
                print("b= ", b, " N=", Nprev, " ", intpart1prev, " ", intpart2prev, " ", Ndiff);
             );
             print("b=", b, " N=", N, " ", intpart1, " ", intpart2, " ", Ndiff);
           );
           Nprev=N;  
           intpart1prev=intpart1;
           intpart2prev=intpart2;
*/
           if(Ndiff>2,
             
             if(Ndiff<4, \\Ndiff==3
                print("--------");
                print("b= ", b, " N=", Nprev1, " ", intpart1prev1, " ", intpart2prev1, " ", Ndiff);
                print("b= ", b, " N=", Nprev, " ", intpart1prev, " ", intpart2prev, " ", Ndiff);
             );
             print("b=", b, " N=", N, " ", intpart1, " ", intpart2, " ", Ndiff);
           );
           Nprev1=Nprev;  
           intpart1prev1=intpart1prev;
           intpart2prev1=intpart2prev;

           Nprev=N;  
           intpart1prev=intpart1;
           intpart2prev=intpart2;

        );       
     );
);
}




\\==========MAIN===PROGRAM==============

{


default(realprecision, 1000);

default(format,"g0.15"); 



\\b=Pi;

\\b=exp(1);
\\b=(1+sqrt(5))/2; 

\\b=sqrt(2);
\\b=sqrt(3);

\\b=2.;
\\b=3.;

\\b=10.;
\\b=sqrt(23);
\\b=sqrt(1.9);

b=3.5;
Precis=50;


present_pi_base_b(b, Precis);
print("PI in base ", b);
v=number_presentation(Pi, b, 15);

/*
print("=================");
x=2.87835;
xx=number_presentation(floor(x*b^10+1/10^Precis), b, 10);
print("test check: ", dk, " ", floor(x*b^10+1/10^Precis));
*/
print("=================");

print("first method");
a=number_presentation(4, b, 10);
print("second method");
b=other_representation(4, b, 10);

print("=================");
\\find_b_w_diff_int_parts();

}
