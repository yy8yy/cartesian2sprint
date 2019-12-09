! File Name: main.f90
! Author: lilulu
! Created Time: Wed 04 Dec 2019 02:19:33 PM CST
! contact matrix A[n,n]
program main
	implicit none
	integer,parameter :: natom = 9,LWORK = 4*natom
	integer :: i,id,info,j 
	real(kind=8) :: x(3,natom),A(natom,natom),energy
	real(kind=8) :: lamda(natom),vec(natom,natom)
	character(len=20) :: fname
	character(len=2) :: atom(natom)
	real(kind=8) :: WORK(LWORK)

	call getarg(1, fname)
	print*,"The ab inito file is ", fname
	open(10, file = fname)
	open(100, file = "sprint.txt")

	id=0
	do while(.true.)
		read(10,*,end=99)
		read(10,*,end=99) energy
		do i=1,natom
			read(10,*) atom(i),x(1:3,i)
		enddo
		id=id+1
		call contact(x,A,atom,natom)
		call dsyev("V","U",natom,A,natom,lamda,WORK,LWORK,info)
		if(info .ne. 0) stop "dsyev exits abnormally."
!		call record(100,natom,A,lamda,energy)
		call record1(100,natom,A,lamda,energy)
	enddo
99	close(10);close(100)
	print*,id,"points"

end


