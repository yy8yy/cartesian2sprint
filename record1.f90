! File Name: record1.f90
! Author: lilulu
! Created Time: Wed 04 Dec 2019 04:17:54 PM CST
subroutine record1(id,n,A,lamda,energy)
	implicit none
	integer,intent(in) :: id,n
	real(kind=8),intent(in) :: A(n,n),lamda(n),energy
	real(kind=8) :: t(n)
	integer :: i

	do i=1,n
		t(i)=maxval(A(1:n,i))
	enddo

	write(id,"(<n+1>(es23.16,2x))") t(1:n)*lamda(n),energy

end subroutine


