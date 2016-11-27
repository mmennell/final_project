class Job < ApplicationRecord
  # Direct associations

  belongs_to :role

  belongs_to :staff,
             :counter_cache => true

  # Indirect associations

  has_one    :restaurant,
             :through => :role,
             :source => :restaurant

  # Validations

end
