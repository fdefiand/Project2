require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should have_many(:camps)
  
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:max_capacity)
  
  should_not allow_value(0).for(:max_capacity)
  should_not allow_value(-1).for(:max_capacity)
  should_not allow_value("abc").for(:zip)
  should_not allow_value("1111").for(:zip)
  
  
  #ASK ABOUT CREATE LOCATION ERROR
  
  context "Creating a location context" do
    setup do
      create_location
    end
    
  should "show location in alphabetical order" do
    assert_equal ["Carnegie Mellon", "Visual Academy"], Location.alphabetical.all.map(&:name)
  end
  
  should "show active and inactive locations" do
    assert_equal ["Carnegie Mellon", "Visual Academy"], Location.active.all.map(&:name)
    assert_equal ["Onii University"], Location.inactive.all.map(&:name)
  end
  end
  
  end
