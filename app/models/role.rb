class Role < ApplicationRecord
  # Direct associations

  has_many   :jobs,
             :dependent => :nullify

  has_many   :staffs,
           :dependent => :nullify

  belongs_to :restaurant,
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :role_name, :uniqueness => { :scope => [:restaurant_id] }

end
