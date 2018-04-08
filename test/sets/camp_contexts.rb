module Contexts
  module CampContexts
    def create_camps
      @pastcamp = FactoryBot.build(:camp, curriculum: @endgames, active: true, location: @cmu, start_date: Date.new(2018,8,1), end_date: Date.new(2018,8,5))
      @camp1 = FactoryBot.build(:camp, curriculum: @openings, active: true, location: @va, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,25))
      @camp2 = FactoryBot.build(:camp, curriculum: @endgames, active: true, location: @ou, start_date: Date.new(2018,8,20), end_date: Date.new(2018,8,25))
      @camp3 = FactoryBot.build(:camp, curriculum: @endgames, time_slot: "pm", active: false, location: @cmu)
    end

    # def delete_curriculums
    #   @endgames.delete
    # end
  end
end