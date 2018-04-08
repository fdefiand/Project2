module Contexts
    module InstructorContexts
        def create_instructors
            @chika = FactoryBot.create(:instructor, first_name: "Chika", bio: nil, phone:"123-123-1212")
            @aoba = FactoryBot.create(:instructor, first_name: "Aoba", last_name: "Suzukaze", bio: "beginner to chess", email: "szaoba@qatar.cmu.edu", active: true)
            @lucy = FactoryBot.create(:instructor, first_name: "Lucy", last_name: "Inactive", active: false)
        end
        
        def delete_instructors
            @chika.delete
            @aoba.delete
            @lucy.delete
        end
    end
end