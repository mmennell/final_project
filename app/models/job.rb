class Job < ApplicationRecord
  # Direct associations

  belongs_to :role

  belongs_to :staff,
             :counter_cache => true

  # Indirect associations

  # Validations

end
