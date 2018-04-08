class Instructor < ApplicationRecord
    
    has_many :camp_instructor
    has_many :camps, through: :camp_instructor
    
    validates :first_name, :last_name, presence: true
    validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "invalid format"}
    validates :phone, format: { with:  /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "area code needed and needs to be at least 10 digits", allow_blank: true }
    
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order('first_name, last_name') }
    scope :needs_bio, -> { where('bio IS NULL') }
    
    #FUNCTIONS
    
    def name
        first_name + ", " + last_name
    end 
    
    def proper_name
        first_name + " " + last_name
    end
    
    def self.for_camp(camp)
        CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    end
    
    
    
    
end
