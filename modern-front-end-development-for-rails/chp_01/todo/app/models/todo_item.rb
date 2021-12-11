class TodoItem < ApplicationRecord
  belongs_to :todo_list
  validates :description, presence: true 
  
  scope :pending,   -> { where(completed: false )}
  scope :completed, -> { where(completed: true )}
end
