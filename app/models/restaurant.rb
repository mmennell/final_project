class Restaurant < ApplicationRecord
  # Direct associations

  # Indirect associations

  # Validations

  validates :restaurant_name, :uniqueness => { :scope => [:address] }

end
