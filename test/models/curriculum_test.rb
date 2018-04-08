require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  should have_many(:camps)
  
  should allow_value(0).for(:min_rating)
  should allow_value(1000).for(:min_rating)

  should allow_value(3000).for(:max_rating)

  should_not allow_value(3001).for(:max_rating)
  should_not allow_value(-1).for(:max_rating)
  should_not allow_value(500.50).for(:max_rating)
  should_not allow_value("abc").for(:max_rating)


  context "Creating a curriculum context" do
    setup do
      create_curriculums
    end
  
  should "show that max rating needs to be greater than min_rating" do
     bad_example = FactoryBot.build(:curriculum, name: "bad example", min_rating: 1000, max_rating: 1000)
     bad_example2 = FactoryBot.build(:curriculum, name: "bad example2", min_rating: 2000, max_rating: 1999)
     deny bad_example.valid?
     deny bad_example2.valid?
   end
  
  should "have a scope to order alphabetically by name" do
    assert_equal ["Chess Contexts", "Chess for Beginners", "Nise-Chess"], Curriculum.alphabetical.all.map(&:name), "#{Curriculum.class}"
  end
  
  should "approve of active curriculums" do
    assert_equal ["Chess Contexts", "Chess for Beginners"], Curriculum.active.all.map(&:name).sort, "#{Curriculum.methods}"
  end
  
  should "show inactive curriculums" do
    assert_equal ["Nise-Chess"], Curriculum.inactive.all.map(&:name).sort
  end
  
  should "show working for_rating scope" do
    assert_equal 1, Curriculum.for_rating(100).size
    assert_equal ["Nise-Chess"], Curriculum.for_rating(600).all.map(&:name).sort
  end
  
end
end
  

