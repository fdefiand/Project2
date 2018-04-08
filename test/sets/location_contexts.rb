module Contexts
  module LocationContexts
        def create_locations
            @cmu = FactoryBot.create(:location, name: "Carnegie Mellon", street_1: "Pitssburgh", street_2: nil, city: "Pittsburgh", zip: "15212")
            @va = FactoryBot.create(:location, name: "Visual Academy", street_1: "Education City", street_2: nil, city: "Doha", zip: "15210")
            @ou = FactoryBot.create(:location, name: "Onii University", street_1: "Ikebukuro", street_2: nil, city: "Ikea", zip: "23210")
        end
    end
end