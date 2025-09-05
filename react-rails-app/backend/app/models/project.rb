class Project < ApplicationRecord
  validates :title, presence: true, length: { minimum: 1, maximum: 100 }
  validates :description, length: { maximum: 500 }
  
  # Set default value for completed
  after_initialize :set_default_completed, if: :new_record?

  private

  def set_default_completed
    self.completed ||= false
  end
end
