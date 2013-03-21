!*********************************************************
! Compute the forces and potential energy for atoms at
! some set of atomic coordinates given by the sx,sy,sz or
! rx,ry,rz arrays.
! Version for tabulated pair potentials
! ****************************************************
	subroutine force
      	include 'md.inc'
	INTEGER :: icell,ix,iy,iz,jx,jy,jz,it1,it2,it3,ind,neg,nabor,is,nsave
	REAL(Kind=Prec14) epsilon,sovr,vcut,fcut,fij,vij,a0,r1,frij
	REAL(Kind=Prec14), DIMENSION(ntma) :: frijpx,frijpy,frijpz
	REAL(Kind=Prec14), DIMENSION(ntma) :: rxij,ryij,rzij,r
	REAL(Kind=Prec14), DIMENSION(ntma) :: rho
	REAL(Kind=Prec14) :: a,b,c,d,ad,bd,cd,dd,fxsum,fysum,fzsum,fmax,fmag,ekin
	REAL(Kind=Prec14) :: xij,yij,zij,rij,qx,qy,qz,vx,vy,vz,vx1,vy1,vz1,vx2,vy2,vz2
	REAL(Kind=Prec14) :: cx,cy,cz,qx1,qx2,qy1,qy2,qz1,qz2
	INTEGER, DIMENSION(ntma) :: jlist

	energy=0.0d0

! Set enthalpy part to zero on first step of averaging

	if(kb.eq.ifaverage) enthav=0.0d0

! Set energy part to zero on first step of averaging

	if(kb.eq.ifaverage) enav=0.0d0

! Set current components to zero

	qx=0.0d0;	qy=0.0d0;	qz=0.0d0
	qx1=0.0d0;	qy1=0.0d0;	qz1=0.0d0 ! Only convection for Pd
	qx2=0.0d0;	qy2=0.0d0;	qz2=0.0d0 ! Only convection for H	 

! Set stress tensor to zero

	stress=0.0d0
	
! Place atoms in linked cell lists


	  call linked
	
	  fx=0.0d0; fy=0.0d0; fz=0.0d0 ! Set forces to zero

	  rho=0.0d0 ! Set the density
	  
	  epot=0.0d0 ! Set potential energy to zero


! Determine the forces on each atom

	    do icell=0,ncell-1
	     iz=icell/ncell_layer
	     iy=mod(icell,ncell_layer)/nnx
	     ix=mod(mod(icell,ncell_layer),nnx)

	     n=ihead(icell)

1000	     if(n.gt.0) then

! Atoms within the same cell

	     j=llist(n)

	     neg=0
	
1100	     if(j.gt.0) then

	      sxij=sx(n)-sx(j)
	      syij=sy(n)-sy(j)
	      szij=sz(n)-sz(j)

	      sxij=sxij-dble(anint(sxij))
	      syij=syij-dble(anint(syij))
	      szij=szij-dble(anint(szij))
	
	      xij=h(1,1)*sxij+h(1,2)*syij+h(1,3)*szij
	      yij=h(2,1)*sxij+h(2,2)*syij+h(2,3)*szij
	      zij=h(3,1)*sxij+h(3,2)*syij+h(3,3)*szij

	      rij=dsqrt(xij**2+yij**2+zij**2)

	      if(rij.le.rc) then  ! Compute interactions
	      r1=rij*sigma

	       neg=neg+1
	       jlist(neg)=j

	       rxij(neg)=xij; ryij(neg)=yij; rzij(neg)=zij; r(neg)=rij

! types of the ions 

		it1=im(n)
	        it2=im(j)	
	        it3=im(n)
	        if(im(n).ne.im(j)) it3=3



! identify the particular slice

	         is=int((r1-rt(1))/hr)
	         a=(rt(is+1)-r1)/hr; ad=-1.0d0/hr
	         b=(r1-rt(is))/hr;   bd= 1.0d0/hr
	         c=(1.0d0/6.0d0)*(a**3-a)*hr**2  
	         d=(1.0d0/6.0d0)*(b**3-b)*hr**2 

! Pair potential

	        vij=a*pt(it3,is)+b*pt(it3,is+1)+c*pt2(it3,is)+d*pt2(it3,is+1)
	        fij=a*pt2(it3,is)+b*pt2(it3,is+1)+c*pt3(it3,is)+d*pt3(it3,is+1)

	        fx(n)=fx(n)-fij*xij/rij
	        fy(n)=fy(n)-fij*yij/rij
	        fz(n)=fz(n)-fij*zij/rij

	        fx(j)=fx(j)+fij*xij/rij
	        fy(j)=fy(j)+fij*yij/rij
	        fz(j)=fz(j)+fij*zij/rij
	   
! Contribution to thermal current

                   vx1=h(1,1)*x1(n)+h(1,2)*y1(n)+h(1,3)*z1(n)
                   vy1=h(2,1)*x1(n)+h(2,2)*y1(n)+h(2,3)*z1(n)
                   vz1=h(3,1)*x1(n)+h(3,2)*y1(n)+h(3,3)*z1(n)

                   vx2=h(1,1)*x1(j)+h(1,2)*y1(j)+h(1,3)*z1(j)
                   vy2=h(2,1)*x1(j)+h(2,2)*y1(j)+h(2,3)*z1(j)
                   vz2=h(3,1)*x1(j)+h(3,2)*y1(j)+h(3,3)*z1(j)

		   vx=vx1+vx2;	vy=vy1+vy2; vz=vz1+vz2
!	           vx=vx/dt; vy=vy/dt; vz=vz/dt

		   fac=(fij/rij)*(xij*vx+yij*vy+zij*vz)

		   qx=qx-0.5d0*xij*fac*sigma
		   qy=qy-0.5d0*yij*fac*sigma
		   qz=qz-0.5d0*zij*fac*sigma

! compute contribution to the stress tensor

		   stress(1,1)=stress(1,1)-(fij*sigma/rij)*xij*xij
		   stress(1,2)=stress(1,2)-(fij*sigma/rij)*xij*yij
		   stress(1,3)=stress(1,3)-(fij*sigma/rij)*xij*zij

		   stress(2,1)=stress(2,1)-(fij*sigma/rij)*yij*xij
		   stress(2,2)=stress(2,2)-(fij*sigma/rij)*yij*yij
		   stress(2,3)=stress(2,3)-(fij*sigma/rij)*yij*zij

		   stress(3,1)=stress(3,1)-(fij*sigma/rij)*zij*xij
		   stress(3,2)=stress(3,2)-(fij*sigma/rij)*zij*yij
		   stress(3,3)=stress(3,3)-(fij*sigma/rij)*zij*zij

		epot=epot+vij

		if(kb.gt.ifaverage) then
		  energy(n)=energy(n)+vij/2.0d0
		  energy(j)=energy(j)+vij/2.0d0
	          enthav(n)=enthav(n)-(1.0d0/3.0d0)*0.5d0*((fij*sigma/rij)*xij*xij+(fij*sigma/rij)*yij*yij+(fij*sigma/rij)*zij*zij)
	          enthav(j)=enthav(j)-(1.0d0/3.0d0)*0.5d0*((fij*sigma/rij)*xij*xij+(fij*sigma/rij)*yij*yij+(fij*sigma/rij)*zij*zij)
	        endif

	      endif

310	      j=llist(j) 
	      goto 1100 

	     endif	! End of neighbors inside same cell

! Atoms within neighboring cells


	 	do jc=1,13
		 jx=ix+jcellx(jc)
		 jy=iy+jcelly(jc)
		 jz=iz+jcellz(jc)
	
	 	 if(jx.lt.0) jx=nnx-1 
	 	 if(jx.gt.nnx-1) jx=0
	 	 if(jy.lt.0) jy=nny-1 
	 	 if(jy.gt.nny-1) jy=0
	 	 if(jz.lt.0) jz=nnz-1 
	 	 if(jz.gt.nnz-1) jz=0

		 jcell=jz*ncell_layer+jy*nnx+jx

	 	 j=ihead(jcell)
	    
	
1200	 	 if(j.gt.0) then


	      	  sxij=sx(n)-sx(j)
	          syij=sy(n)-sy(j)
	          szij=sz(n)-sz(j)


! Periodic boundary conditions

	          sxij=sxij-dble(anint(sxij))
	          syij=syij-dble(anint(syij))
	          szij=szij-dble(anint(szij))

	          xij=h(1,1)*sxij+h(1,2)*syij+h(1,3)*szij
	          yij=h(2,1)*sxij+h(2,2)*syij+h(2,3)*szij
	          zij=h(3,1)*sxij+h(3,2)*syij+h(3,3)*szij

	          rij=dsqrt(xij**2+yij**2+zij**2)
	 
	
	          if(rij.le.rc) then  ! Compute interactions
	           r1=rij*sigma
	 
	           neg=neg+1 	  
	           jlist(neg)=j

		   rxij(neg)=xij; ryij(neg)=yij; rzij(neg)=zij; r(neg)=rij

! types of the ions 

		   it1=im(n)
	           it2=im(j)	
	           it3=im(n)
	           if(im(n).ne.im(j)) it3=3

! identify the particular slice

	         is=int((r1-rt(1))/hr)
	         a=(rt(is+1)-r1)/hr
	         b=(r1-rt(is))/hr
	         c=(1.0d0/6.0d0)*(a**3-a)*hr**2
	         d=(1.0d0/6.0d0)*(b**3-b)*hr**2

! Pair potential

	           vij=a*pt(it3,is)+b*pt(it3,is+1)+c*pt2(it3,is)+d*pt2(it3,is+1)
	           fij=a*pt2(it3,is)+b*pt2(it3,is+1)+c*pt3(it3,is)+d*pt3(it3,is+1)


	           fx(n)=fx(n)-fij*xij/rij
	           fy(n)=fy(n)-fij*yij/rij
	           fz(n)=fz(n)-fij*zij/rij

	           fx(j)=fx(j)+fij*xij/rij
	           fy(j)=fy(j)+fij*yij/rij
	           fz(j)=fz(j)+fij*zij/rij

! Contribution to thermal current

                   vx1=h(1,1)*x1(n)+h(1,2)*y1(n)+h(1,3)*z1(n)
                   vy1=h(2,1)*x1(n)+h(2,2)*y1(n)+h(2,3)*z1(n)
                   vz1=h(3,1)*x1(n)+h(3,2)*y1(n)+h(3,3)*z1(n)

                   vx2=h(1,1)*x1(j)+h(1,2)*y1(j)+h(1,3)*z1(j)
                   vy2=h(2,1)*x1(j)+h(2,2)*y1(j)+h(2,3)*z1(j)
                   vz2=h(3,1)*x1(j)+h(3,2)*y1(j)+h(3,3)*z1(j)

		   vx=vx1+vx2;	vy=vy1+vy2; vz=vz1+vz2
!	           vx=vx/dt; vy=vy/dt; vz=vz/dt

		   fac=(fij/rij)*(xij*vx+yij*vy+zij*vz)

		   qx=qx-0.5d0*xij*fac*sigma
		   qy=qy-0.5d0*yij*fac*sigma
		   qz=qz-0.5d0*zij*fac*sigma

! compute contribution to the stress tensor

		   stress(1,1)=stress(1,1)-(fij*sigma/rij)*xij*xij
		   stress(1,2)=stress(1,2)-(fij*sigma/rij)*xij*yij
		   stress(1,3)=stress(1,3)-(fij*sigma/rij)*xij*zij

		   stress(2,1)=stress(2,1)-(fij*sigma/rij)*yij*xij
		   stress(2,2)=stress(2,2)-(fij*sigma/rij)*yij*yij
		   stress(2,3)=stress(2,3)-(fij*sigma/rij)*yij*zij

		   stress(3,1)=stress(3,1)-(fij*sigma/rij)*zij*xij
		   stress(3,2)=stress(3,2)-(fij*sigma/rij)*zij*yij
		   stress(3,3)=stress(3,3)-(fij*sigma/rij)*zij*zij
	  
		   epot=epot+vij 
	          
 	           if(kb.gt.ifaverage) then	 
		    energy(n)=energy(n)+vij/2.0d0
		    energy(j)=energy(j)+vij/2.0d0
	            enthav(n)=enthav(n)-(1.0d0/3.0d0)*0.5d0*((fij*sigma/rij)*xij*xij+(fij*sigma/rij)*yij*yij+(fij*sigma/rij)*zij*zij)
	            enthav(j)=enthav(j)-(1.0d0/3.0d0)*0.5d0*((fij*sigma/rij)*xij*xij+(fij*sigma/rij)*yij*yij+(fij*sigma/rij)*zij*zij)
	 	   endif

	         endif
	     
	     j=llist(j)	
	     goto 1200
	     endif
	    enddo ! End loop on neighboring cells jc

	   n=llist(n) ! Next atom in cell
	   goto 1000 

	  endif
	enddo

! Add local energy terms thermal current components
! Determine mass current of species 2

	cx=0.0d0; cy=0.0d0; cz=0.0d0

!	qx=0.0d0; qy=0.0d0; qz=0.0d0

	do n=1,natoms
           vx=h(1,1)*x1(n)+h(1,2)*y1(n)+h(1,3)*z1(n)
           vy=h(2,1)*x1(n)+h(2,2)*y1(n)+h(2,3)*z1(n)
           vz=h(3,1)*x1(n)+h(3,2)*y1(n)+h(3,3)*z1(n)

	   vsq=vx**2+vy**2+vz**2; vsq=vsq/dtsq
	   ekin=0.5*am(n)*vsq

	    energy(n)=energy(n)+ekin

	   if(kb.gt.ifaverage) then
	    enav(n)=enav(n)+energy(n)
	    enthav(n)=enthav(n)+energy(n)
	   endif
!	   vx=vx/dt; vy=vy/dt; vz=vz/dt

	   if(im(n).eq.1) then
	    qx1=qx1+vx*energy(n); qy1=qy1+vy*energy(n); qz1=qz1+vz*energy(n)
	   endif

	   if(im(n).eq.2) then
	    qx2=qx2+vx*energy(n); qy2=qy2+vy*energy(n); qz2=qz2+vz*energy(n)
	   endif

	   qx=qx+vx*energy(n); qy=qy+vy*energy(n); qz=qz+vz*energy(n)

!	   if(im(n).eq.2) write(6,*) energy(n)

	   if(im(n).eq.2) then
	    cx=cx+vx; cy=cy+vy; cz=cz+vz
	   endif
	enddo

	 if(kb.gt.ifaverage) write(25,308) cx,cy,cz,qx,qy,qz
	 if(kb.gt.ifaverage) write(26,308) qx1,qy1,qz1,qx2,qy2,qz2

299	format(3f18.6)
301	format(i8,2f12.6)
308	format(6f18.6)
	return
	end
