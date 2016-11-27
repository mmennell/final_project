class Role < ApplicationRecord
  # Direct associations

  belongs_to :restaurant,
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :role_name, :uniqueness => { :scope => [:restaurant_id] }

end
