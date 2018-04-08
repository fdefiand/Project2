class CampInstructor < ApplicationRecord
    
    belongs_to :camp
    belongs_to :instructor
    
    validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validates :instructor_id, presence: true, numericality: { greater_than: 0, only_integer: true }
    validate :activeinstructor
    validate :activecamps
    validate :instructornotincamp, on: :create
    validate :already_assigned_to_another_camp, on: :create
    
    # FUNCTIONS
    
    def activeinstructor
        return if self.instructor.nil?
        errors.add(:instructor, "is not active") unless self.instructor.active
    end
    
    def activecamps
        return if self.camp.nil?
        errors.add(:camp, "is not active") unless self.camp.active
    end
    
    def instructornotincamp
        return true if self.camp.nil? || self.instructor.nil?
        unless CampInstructor.where(camp_id: self.camp_id, instructor_id: self.instructor_id).to_a.empty?
            errors.add(:base, "This instructor is already in camp") 
        end
    end
    
    def already_assigned_to_another_camp
        return true if self.camp.nil? || self.instructor.nil?
        assigned_to_other_camp = Camp.where(start_date: self.camp.start_date, time_slot: self.camp.time_slot).map{|c| c.instructors}.flatten
        if assigned_to_other_camp.include?(self.instructor)
            errors.add(:base, "This instructor is already in another camp")
        end
    end
    
    
end
