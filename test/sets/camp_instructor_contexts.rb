module Contexts
    module CampInstructorContexts
        def create_camp_instructors
            @aoba_1 = FactoryBot.create(:camp_instructor, instructor: @aoba, camp: @camp1)
            @aoba_2 = FactoryBot.create(:camp_instructor, instructor: @aoba, camp: @camp2)
            @chika_1 = FactoryBot.create(:camp_instructor, instructor: @chika, camp: @camp3)
            
        end
    end
end