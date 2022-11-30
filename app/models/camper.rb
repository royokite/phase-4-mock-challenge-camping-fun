class Camper < ApplicationRecord
    has_many :signups
    has_many :activities, through: :signups

    validates :name, presence: true
    validates :age, numericality: { greater_than_or_equal_to: 8, less_than_or_equal_to: 18, message: "must be between 8 and 18" }
end
