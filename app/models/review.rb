class Review < ActiveRecord::Base
  belongs_to :product

  validates :stars, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 0}
end
