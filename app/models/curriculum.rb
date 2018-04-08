class Curriculum < ApplicationRecord
    
 has_many :camps
    
  validates_presence_of :name
  
  valid_ratings = [0] + (100..3000).to_a
  validates :min_rating, numericality: true, inclusion: {in: valid_ratings}
  validates :max_rating, numericality: true, inclusion: {in: valid_ratings}
  validate :max_rating_greater_than_min_rating
  

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }


  def max_rating_greater_than_min_rating
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end


end