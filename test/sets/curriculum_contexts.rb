module Contexts
  module CurriculumContexts
    def create_curriculums
      @endgames   = FactoryBot.create(:curriculum, name: "Chess Contexts", min_rating: 710, max_rating: 1200)
      @openings    = FactoryBot.create(:curriculum, name: "Chess for Beginners", min_rating: 0, max_rating: 500)
      @falsechess = FactoryBot.create(:curriculum, name: "Nise-Chess", active: false)
    end

    # def delete_curriculums
    #   @endgames.delete
    # end
  end
end