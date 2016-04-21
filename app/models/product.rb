class Product < ActiveRecord::Base

  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  def favourite_for(user)
    favourites.find_by_user_id(user)
  end

  after_initialize :default_values

  validates :title, presence: true, uniqueness: {message: "must be unique!"}

  #validates(:description,{presence: true, length: {minimum: 10}})

  validates(:price, {presence: true})
  validates :sale_price, presence: true
  validates :sale_price, numericality: {less_than_or_equal_to: :price}

  #after_initialize :set_defaults

  #before_validation :titleize_title

  private
  def default_values
    self.sale_price ||= price
  end
  #def titleize_title
  #  self.title = title.titleize
  #end

end
