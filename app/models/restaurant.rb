class Restaurant < ApplicationRecord
  # Direct associations

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :restaurant_name, :uniqueness => { :scope => [:address] }

end
