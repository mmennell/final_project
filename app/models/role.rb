class Role < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :role_name, :uniqueness => { :scope => [:restaurant_id] }

end
