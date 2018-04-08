require 'test_helper'

class CampTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should belong_to(:curriculum)
  should have_many(:camp_instructors)
  should have_many(:instructors).through(:camp_instructors)
  should belong_to(:location)
  
  should validate_presence_of(:location_id)
  should validate_presence_of(:curriculum_id)
  should validate_presence_of(:start_date)
  should validate_presence_of(:end_date)
  should validate_presence_of(:time_slot)
  
  should allow_value(Date.today).for(:start_date)
  should allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value("abc").for(:start_date)
  should_not allow_value(1).for(:start_date)
  should_not allow_value(1.4345).for(:start_date)
  
  should_not allow_value("abc").for(:end_date)
  should_not allow_value(1).for(:end_date)
  should_not allow_value(1.334).for(:end_date)
  
  should validate_numericality_of(:cost)
  should allow_value(0).for(:cost)
  should allow_value(100).for(:cost)
  should_not allow_value(-1).for(:cost)
  should_not allow_value("abc").for(:cost)
  
  should allow_value("am").for(:time_slot)
  should allow_value("pm").for(:time_slot)
  should_not allow_value("abc").for(:time_slot)
  should_not allow_value("12:00").for(:time_slot)
  should_not allow_value(12345).for(:time_slot)
  
  should validate_numericality_of(:max_students)
  should allow_value(1).for(:max_students)
  should allow_value(12).for(:max_students)
  should_not allow_value(0).for(:max_students)
  should_not allow_value("abc").for(:max_students)
  should_not allow_value(-1).for(:max_students)
  should_not allow_value(2.4).for(:max_students)
  
  
  context "Create camps" do
    setup do
      create_curriculums
      create_locations
      create_camps
    end
  
  should "verify camp name method" do
    assert_equal "Chess for Beginners", @camp1.name
  end
  
  should "have for_curriculum scope" do
    assert_equal ["Chess Contexts"], Camp.for_curriculum(@endgames.id).all.map(&:name).sort
  end
  
  should "verify active camps" do
    assert_equal ["Chess Contexts", "Chess for Beginners"], Camp.active.all.map{|c| c.curriculum_name}.sort
  end
  
  should "Show camps in alphabetical order" do
    assert_equal ["Chess Contexts", "Chess for Beginners", "Chess Contexts", "Chess Contexts"], Camp.alphabetical.all.map{|c| c.curriculum_name}
  end

  should "show camps with different locations can be created" do
    @sample = FactoryBot.build(:camp, curriculum: @openings, location: @cmu, start_date: Date.new(2018,8,20), end_date: Date.new(2018,8,27), time_slot: 'am')
    assert @ok_camp.valid?
  end

  should "show that duplicates cannot be created" do
    @duplicate = FactoryBot.build(:camp, curriculum: @openings, location: @va, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,25))
    deny @duplicate.valid?
  end

  should "show that camps that have finished are still editable" do
    @camp1.update_attribute(:start_date, 10.days.ago.to_date)
    @camp1.update_attribute(:end_date, 3.days.ago.to_date)
    @camp1.max_students = 10
    @camp1.save!
    @camp1.reload 
    assert_equal 10, @camp1.max_students
  end

  
end
end
