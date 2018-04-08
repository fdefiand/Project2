require 'test_helper'

class CampInstructorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:instructor)
  should belong_to(:camp)
  
  should validate_presence_of(:instructor_id)
  should validate_presence_of(:camp_id)
  should validate_numericality_of(:instructor_id).only_integer.is_greater_than(0)
  should validate_numericality_of(:camp_id).only_integer.is_greater_than(0)
  
  include Contexts
  context "Camp_Instructor context" do
    setup do
      create_curriculums
      create_locations
      create_instructors
      create_camps
      create_camp_instructors
    end
    
    should "not allow same instructor to be assigned twice to the same camp" do
      invalid = FactoryBot.build(:camp_instructor, instructor: @aoba, camp: @camp1)
      deny invalid.valid?
    end
    
    should "not allow instructor to be assigned to inactive camp" do
      inactive_camp = FactoryBot.build(:camp_instructor, instructor: @aoba, camp: @camp3)
      deny inactive_camp.valid?
    end
    
    should "not allow inactive instructor to be assigned to a camp" do
      inactive_instructor = FactoryBot.build(:camp_instructor, instructor: @lucy, camp: @camp1)
      deny inactive_instructor.valid?
    end
    
  end
end