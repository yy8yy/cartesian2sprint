! File Name: contact.f90
! Author: lilulu
! Created Time: Wed 04 Dec 2019 02:41:53 PM CST
subroutine contact(x,A,atom,n)
	implicit none
	integer :: i,j
	integer,intent(in) :: n
	real(kind=8),intent(in) :: x(3,n) 
	real(kind=8),intent(out) :: A(n,n)
	character(len=2),intent(in) :: atom(n)
	real(kind=8) :: di,dj,dij,rij,zi

	A=0.0d0
	do i=1,n-1
		call bondstd(i,atom,n,di)
		call atomZ(i,atom,n,zi)
		A(i,i)=1.0d0 + zi/10.0d0
		do j=i+1,n		
			call bondstd(j,atom,n,dj)
			dij=1.15d0*(di+dj)  ! 1.15 advised by Sob.
			rij=dsqrt(dot_product(x(1:3,i)-x(1:3,j),x(1:3,i)-x(1:3,j)))
			A(i,j)=(1-(rij/dij)**6.0d0) / (1-(rij/dij)**12.0d0)
			A(j,i)=A(i,j)
		enddo
	enddo
	call atomZ(n,atom,n,zi)
	A(n,n)=1.0d0 + zi/10.0d0

end subroutine
subroutine bondstd(i,atom,n,d)
! Covalent radii revisited. doi:10.1039/B801115J
	implicit none
	integer,intent(in) :: i,n
	real(kind=8),intent(out) :: d
	character(len=2),intent(in) :: atom(n)

		if(atom(i).eq.'H') then
			d=0.31d0
		else if(atom(i).eq.'O') then
			d=0.66d0
		else if(atom(i).eq.'I') then
			d=1.39d0
		else if(atom(i).eq.'C') then
			d=0.76d0
		else if(atom(i).eq.'F') then
			d=0.57d0
		else
			print*,"the radii of",atom(i),"is not defined"
			stop
		endif

end subroutine
subroutine atomZ(i,atom,n,z)
	implicit none
	integer,intent(in) :: i,n
	real(kind=8),intent(out) :: z
	character(len=2),intent(in) :: atom(n)

		if(atom(i).eq.'H') then
			z=1.0d0
		else if(atom(i).eq.'O') then
			z=8.0d0
		else if(atom(i).eq.'I') then
			z=53.0d0
		else if(atom(i).eq.'C') then
			z=6.0d0
		else if(atom(i).eq.'F') then
			z=9.0d0
		else
			print*,"the atom order of",atom(i),"is not defined"
			stop
		endif

end subroutine



