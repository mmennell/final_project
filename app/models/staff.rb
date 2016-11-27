class Staff < ApplicationRecord
  # Direct associations

  has_many   :jobs,
             :dependent => :nullify

  belongs_to :home_restaurant,
             :class_name => "Restaurant",
             :counter_cache => true

  belongs_to :user

  # Indirect associations

  # Validations

end
