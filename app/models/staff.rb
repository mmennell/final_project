class Staff < ApplicationRecord
  # Direct associations

  has_many   :jobs,
             :dependent => :nullify

  belongs_to :home_restaurant,
             :class_name => "Restaurant",
             :counter_cache => true

  belongs_to :role,
             :class_name => "Role"

  belongs_to :user

  # Indirect associations

  # Validations
    validates(:first_name, presence: true)
    validates(:last_name, presence: true)
    validates(:contact_telephone, presence: true)
    validates(:avatar_url, presence: true)
    validates(:home_restaurant, presence: true)

end
