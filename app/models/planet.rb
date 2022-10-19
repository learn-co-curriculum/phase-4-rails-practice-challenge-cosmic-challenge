class Planet < ApplicationRecord
    has_many :missions
    has_many :scientists, through: :missions
end
