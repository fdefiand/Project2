require 'test_helper'

class InstructorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should have_many(:camp_instructor)
  should have_many(:camps).through(:camp_instructors)
  
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email).case_insensitive
  
  should allow_value("faiq@qatar.cmu.edu").for(:email)
  should allow_value("faiq@faiq.com").for(:email)
  should allow_value("faiq@faiq.org").for(:email)
  should allow_value("faiq@faiq.net").for(:email)
  
  should_not allow_value("faiq").for(:email)
  should_not allow_value("mule mule@qatar.cmu.edu").for(:email)
  
  should allow_value("111-111-1111").for(:phone)
  should allow_value("1111111111").for(:phone)
  should allow_value("111.111.1111").for(:phone)
  should allow_value("(111) 111-1111").for(:phone)
  
  should_not allow_value("1").for(:phone)
  should_not allow_value("12345").for(:phone)
  should_not allow_value("111-ABC-ABCD").for(:phone)
  should_not allow_value("111/111/1111").for(:phone)
  should_not allow_value("111-1111-111").for(:phone)
  should_not allow_value("1111-1111-1111").for(:phone)
  should_not allow_value("1111-111-111").for(:phone)
  
  
  context "Create an instructor context" do
    setup do
      create_instructors
    end
    
    teardown do
      delete_instructors
    end
    
    
    
  should "show instructors in alphabetical order" do
    assert_equal ["Aoba", "Chika", "Lucy"], Instructor.alphabetical.all.map(&:first_name)
  end
  
  should "show active instructors" do
    assert_equal ["Aoba", "Chika"], Instructor.active.all.map(&:first_name).sort
  end
  
  should "show inactive instructors" do
    assert_equal ["Lucy"], Instructor.inactive.all.map(&:first_name).sort
  end
  
  should "show name" do
    assert_equal "Aoba, Suzukaze", @aoba.name
  end
  
  should "show proper name" do
    assert_equal "Aoba Suzukaze", @aoba.proper_name
  end
  
  
  should "show instructor who need bio" do
    assert_equal ["Chika"], Instructor.needs_bio.all.map(&:first_name).sort
  end
  

  
  
  
end
end
