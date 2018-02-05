function [SR, S, SC] = atmo3dlax2 (Uwind,alp, beta, nx, ny, nz, xlim, ylim, zlim, Ky, Kz, dt)
dx =( xlim(2) - xlim(1))/nx;
dy = (ylim(2) - ylim(1))/ny;
dz = (zlim(2) - zlim(1))/nz;


x0 = xlim(1) + [0:nx]*dx;   % distance along wind direction (m)

Ux = Uwind * cos(alp)*cos(beta);
Uy = Uwind * cos(alp)*sin(beta);
Uz = Uwind * sin(alp);

cx = Ux * dt/dx;
cy = Uy * dt/(dy);
cz = Uz * dt/(dz);

sy = Ky * dt/(dy^2);
sz = Kz * dt/(dz^2);


NR = 1;
NC = 1;


       
        
        
        
        
        
for k = 1
    for j= 2
         for i = 2
        
       
   
        S(1, NR)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy - cz;
        S(1, NR+1)  =  1/2*(cx^2 );
        S(1, NR+2)  =   sy(i,1); 
        S(1, NR+3) = 2* sz(i,1) + cz;
        
        
             
            
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+3) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
        for i = 3 : nx - 1                       
        
       
        S(1, NR)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy - cz;
        S(1, NR+2)  =  1/2*(cx^2 );
        S(1, NR+3)  =   sy(i,1); 
        S(1, NR+4) = 2* sz(i,1)+cz;
        
        
            
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;                   
        end
        for i = nx
        
       
        S(1, NR)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy - cz;
       
        S(1, NR+2)  =   sy(i,1); 
        S(1, NR+3) = 2* sz(i,1)+ cz;
        
        
             
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+3) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
    end
    for j = 3 : ny - 1
        for i = 2
        
        S(1, NR)  =   sy(i,1)+cy;
   
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy - cz;
        S(1, NR+2)  =  1/2*(cx^2 );
        S(1, NR+3)  =   sy(i,1); 
        S(1, NR+4) = 2* sz(i,1)+cz;
        
        
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
        for i = 3 : nx - 1                       
       
        S(1, NR)  =   sy(i,1)+cy;
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy - cz;
        S(1, NR+3)  =  1/2*(cx^2);
        S(1, NR+4)  =   sy(i,1); 
        S(1, NR+5) = 2* sz(i,1)+cz;
        
        
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+5) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;                   
        end
        for i = nx
        
        S(1, NR)  =   sy(i,1)+cy;
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx - cy -cz;
       
        S(1, NR+3)  =   sy(i,1); 
        S(1, NR+4) = 2* sz(i,1)+ cz;
        
        
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
       
    end
    for j = ny
         for i = 2
       
        S(1, NR)  =   sy(i,1)+cy;
   
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 - cx - cy -cz;
        S(1, NR+2)  =  1/2*(cx^2 );
       
        S(1, NR+3) = 2* sz(i,1)+cz;
        
        
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
       
        SC(1, NR+3) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
        for i = 3 : nx - 1                       
        
        S(1, NR)  =   sy(i,1)+cy;
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx - cy - cz;
        S(1, NR+3)  =  1/2*(cx^2);
        
        S(1, NR+4) = 2* sz(i,1)+cz;
        
       
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;                   
        end
        for i = nx
        
        S(1, NR)  =   sy(i,1)+cy;
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy - cz;
       
        
        S(1, NR+3) = 2* sz(i,1)+cz;
        
       
        SC(1, NR) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        
        SC(1, NR+3) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
    end
   
end
for k = 2 : nz -1 
    for j= 2
         for i = 2
        S(1, NR)    =   sz(i,1)+cz;
       
   
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx - cy - cz;
        S(1, NR+2)  =  1/2*(cx^2 );
        S(1, NR+3)  =   sy(i,1); 
        S(1, NR+4) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
             
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1)+cz;
       
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy-cz;
        S(1, NR+3)  =  1/2*(cx^2 );
        S(1, NR+4)  =   sy(i,1); 
        S(1, NR+5) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+5) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+cz;
       
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy - cz;
       
        S(1, NR+3)  =   sy(i,1); 
        S(1, NR+4) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
             
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
    end
    for j = 3 : ny - 1
        for i = 2
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
   
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+3)  =  1/2*(cx^2 );
        S(1, NR+4)  =   sy(i,1); 
        S(1, NR+5) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+5) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1) +  cz;
        S(1, NR+1)  =   sy(i,1) + cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+4)  =  1/2*(cx^2);
        S(1, NR+5)  =   sy(i,1) ; 
        S(1, NR+6) = sz(i,1) ;
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+5) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+6) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 6) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 7;
        NR = NR + 7;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+ cz;
        S(1, NR+1)  =   sy(i,1)+ cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
       
        S(1, NR+4)  =   sy(i,1); 
        S(1, NR+5) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        SC(1, NR+5) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;    
        end
       
    end
    for j = ny
         for i = 2
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
   
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy - cz;
        S(1, NR+3)  =  1/2*(cx^2 );
       
        S(1, NR+4) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
       
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+4)  =  1/2*(cx^2 );
        
        S(1, NR+5) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        
        SC(1, NR+5) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
       
        
        S(1, NR+4) = sz(i,1);
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        
        SC(1, NR+4) = (nx-1)*(ny-1)*(k) + (nx-1)*(j-2) + i-1;
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
    end
   
end
for k = nz
    for j= 2
         for i = 2
        S(1, NR)    =   sz(i,1)+cz;
       
   
        S(1, NR+1)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+2)  =  1/2*(cx^2 );
        S(1, NR+3)  =   sy(i,1); 
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
             
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
       
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1)+cz;
       
        S(1, NR+1)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+3)  =  1/2*(cx^2 );
        S(1, NR+4)  =   sy(i,1); 
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
            
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+cz;
       
        S(1, NR+1)  =  1/2*(cx^2 +2* cx);
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2-cx -cy -cz;
       
        S(1, NR+3)  =   sy(i,1); 
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
             
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
    end
    for j = 3 : ny - 1
        for i = 2
        S(1, NR)    =   sz(i,1)+cy;
        S(1, NR+1)  =   sy(i,1)+cz;
   
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+3)  =  1/2*(cx^2 );
        S(1, NR+4)  =   sy(i,1); 
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
       
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+4)  =  1/2*(cx^2 );
        S(1, NR+5)  =   sy(i,1); 
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        SC(1, NR+5) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
       
        
        SR( 1, NC: NC + 5) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 6;
        NR = NR + 6;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
       
        S(1, NR+4)  =   sy(i,1); 
        x0
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-1)+i-1; 
        
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;    
        end
       
    end
    for j = ny
         for i = 2
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
   
        S(1, NR+2)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy - cz;
        S(1, NR+3)  =  1/2*(cx^2 );
       
       
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
            
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
       
       
        
        SR( 1, NC: NC + 3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
        for i = 3 : nx - 1                       
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
        S(1, NR+4)  =  1/2*(cx^2 );
        
        
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        SC(1, NR+4) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i;        
        
        
        
        SR( 1, NC: NC + 4) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 5;
        NR = NR + 5;                   
        end
        for i = nx
        S(1, NR)    =   sz(i,1)+cz;
        S(1, NR+1)  =   sy(i,1)+cy;
        S(1, NR+2)  =  1/2*(cx^2 + 2* cx);
        S(1, NR+3)  =  1 - 2 * sy(i,1) - 2 * sz(i,1) - cx^2 -cx -cy -cz;
       
        
      
        
        SC(1, NR)   =   (nx-1)*(ny-1)*(k-2)+(nx-1)*(j-2)+i-1;
        SC(1, NR+1) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-3)+i-1;        
        SC(1, NR+2) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-2;        
        SC(1, NR+3) =   (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
            
        
       
        
        SR( 1, NC: NC +3) = (nx-1)*(ny-1)*(k-1)+(nx-1)*(j-2)+i-1;        
        NC = NC + 4;
        NR = NR + 4;    
        end
    end
   
end