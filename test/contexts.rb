require './test/sets/curriculum_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_contexts'
require './test/sets/camp_instructor_contexts'
require './test/sets/location_contexts'


module Contexts
  include Contexts::CurriculumContexts
  include Contexts::InstructorContexts
  include Contexts::CampContexts
  include Contexts::CampInstructorContexts
  include Contexts::LocationContexts
  
  def create_contexts
    create_curriculums
    create_instructors
    create_contexts
    create_camp_instructors
    create_locations
    # delete_curriculums
  end
  
  
  
end