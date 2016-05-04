class Review < ActiveRecord::Base
  belongs_to :product

  validates :stars, presence: true, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 0}

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

    def like_for(user)
      likes.find_by_user_id(user)
    end

end
