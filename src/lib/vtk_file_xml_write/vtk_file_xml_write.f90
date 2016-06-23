!< VTK file XML write.
module vtk_file_xml_write
!-----------------------------------------------------------------------------------------------------------------------------------
!< VTK file abstract XML write.
!-----------------------------------------------------------------------------------------------------------------------------------
use vtk_file_abstract_xml_write
use vtk_file_xml_write_ascii_local_state
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
implicit none
private
public :: xml_write
!-----------------------------------------------------------------------------------------------------------------------------------

!-----------------------------------------------------------------------------------------------------------------------------------
type, extends(abstract_xml_write) :: xml_write
  !< VTK file XML write.
  class(abstract_xml_write_state), allocatable, private :: current !< Current state.
  contains
    ! procedure, pass :: initialize               !< Initialize write object.
    procedure, pass :: set_state                !< Set state.
    procedure, pass :: write => write_xml_write !< Write VTK file data.
endtype xml_write
!-----------------------------------------------------------------------------------------------------------------------------------
contains
  subroutine set_state(self, state)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Set state.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(xml_write),                intent(inout) :: self  !< Write object.
  class(abstract_xml_write_state), intent(in)    :: state !< Write object state.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  if (.not.same_type_as(state, self%current)) then
     if (allocated(self%current)) deallocate(self%current)
     allocate(self%current, source=state)
  endif
  !---------------------------------------------------------------------------------------------------------------------------------
  endsubroutine set_state

  subroutine write_xml_write(self)
  !---------------------------------------------------------------------------------------------------------------------------------
  !< Set state.
  !---------------------------------------------------------------------------------------------------------------------------------
  class(xml_write), intent(inout) :: self !< Write object.
  !---------------------------------------------------------------------------------------------------------------------------------

  !---------------------------------------------------------------------------------------------------------------------------------
  call self%current%write(xml_write=self)
  !---------------------------------------------------------------------------------------------------------------------------------
  endsubroutine write_xml_write
endmodule vtk_file_xml_write
