class Scientist < ApplicationRecord
    has_many :missions, dependent: :destroy
    has_many :planets, through: :missions

    validates :name, presence: true, uniqueness: true
    validates :field_of_study, presence: true
end
