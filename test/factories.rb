FactoryBot.define do
  
  factory :curriculum do
    name "Chess Beginners"
    description "This is the Chess camp."
    min_rating 400
    max_rating 850
    active true
  end
  
  factory :instructor do
    first_name "Faiq"
    last_name "Defiandry"
    bio "Faiq is a beginner in chess."
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    email { |i| "#{i.first_name[0]}#{i.last_name}#{(1..99).to_a.sample}@example.com".downcase }
    active true
  end
  
  factory :camp do 
    cost 150
    start_date Date.new(2018,7,20)
    end_date Date.new(2018,7,25)
    time_slot "am"
    max_students 8
    active true
    association :curriculum
    association :location
  end
  
  factory :camp_instructor do 
    association :camp
    association :instructor
  end

  factory :location do
    name "Carnegie Mellon Qatar"
    street_1 "Education City"
    street_2 "Doha Road"
    city "Road"
    state "DOH"
    zip "15213"
    max_capacity 20
    active true
  end

end