class Planet < ApplicationRecord
    has_many :missions, dependent: :destroy
    has_many :scientists, through: :missions
end
