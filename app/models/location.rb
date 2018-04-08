class Location < ApplicationRecord
    
    has_many :camps
    
    validates_presence_of :street_1
    validates :name, presence: true
    validates :zip, presence: true, format: {with: /\A\d{5}\z/, message: "must be 5 characters long"}
    validates :max_capacity, presence: true, numericality: {only_integer: true, greater_than: 0}
    validates_uniqueness_of :name
    
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :alphabetical, -> { order("name, street_1") }
    
    # FUNCTIONS
    
end
