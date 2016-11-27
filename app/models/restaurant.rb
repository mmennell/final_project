class Restaurant < ApplicationRecord
  # Direct associations

  has_many   :roles,
             :dependent => :destroy

  has_many   :staffs,
             :foreign_key => "home_restaurant_id",
             :dependent => :nullify

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

  validates :restaurant_name, :uniqueness => { :scope => [:address] }

end
