class Camp < ApplicationRecord
  
    has_many :camp_instructors
    has_many :instructors, through: :camp_instructors
    belongs_to :location
    belongs_to :curriculum
    
    validates_presence_of :location_id, :curriculum_id, :time_slot, :start_date
    validate :curriculum_is_active_in_system
    validate :location_is_active_in_system
    validates :curriculum_id, :location_id, :cost, :start_date, :end_date, :time_slot, presence: true
    validates_numericality_of :cost, greater_than_or_equal_to: 0
    validates_numericality_of :max_students, only_integer: true, greater_than:0
    validates_inclusion_of :time_slot, in: %w[am pm], message: "is not a valid time slot format"
    validates_date :start_date, :on_or_after => lambda {Date.today}, :on_or_after_message => "Can't be in the past", on: :create
    validates_date :end_date, :on_or_after => :start_date
    validate :camp_is_not_duplicate, on: :create
    validate :max_student_lower_than_capacity

    #SCOPES
    
    
    scope :alphabetical, -> { joins(:curriculum).order('name') }
    scope :chronological, -> {order('start_date , end_date')} 
    scope :active, -> { where(active: true) }
    scope :inactive, -> { where(active: false) }
    scope :morning, -> { where("time_slot = ?", 'am') }
    scope :afternoon, -> { where("time_slot = ?", 'pm') }
    scope :upcoming, -> { where("start_date >= ?", Date.today ) }
    scope :past, -> { where("end_date < ?", Date.today) }
    scope :for_curriculum, ->(curriculum_id) { where("curriculum_id = ?", curriculum_id) }
    
    
    # FUNCTIONS
    
  def name
    self.curriculum.name
  end
    
    
  private 
  
  def curriculum_is_active_in_system
    return if self.curriculum.nil?
    errors.add(:curriculum, "is not currently active") unless self.curriculum.active
  end
  
  def location_is_active_in_system
    return if self.location.nil?
    errors.add(:location, "is not currently active") unless self.location.active
  end
  
  def remove_instructor
    if self.active != true
      self.camp_instructors.each {|ci| ci.destroy}
    end
  end
  
  def camp_is_not_duplicate
    return true if self.start_date.nil? || self.location_id.nil? || self.time_slot.nil?
    if self.already_exists?
      errors.add(:time_slot, "already exists for a start date, a time slot and camp location")
    end
  end
  
  def max_student_lower_than_capacity
    return true if self.location_id.nil? || self.max_students.nil?
    if self.max_students > self.location.max_capacity
      errors.add(:max_students, "is greater than the camp capacity")
    end
  end
end