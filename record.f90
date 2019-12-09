! File Name: record.f90
! Author: lilulu
! Created Time: Wed 04 Dec 2019 04:17:54 PM CST
subroutine record(id,n,A,lamda,energy)
	implicit none
	integer,intent(in) :: id,n
	real(kind=8),intent(in) :: A(n*n),lamda(n),energy

	write(id,"(82(es23.16,2x))") A(1:n*n)*lamda(n),energy

end subroutine


