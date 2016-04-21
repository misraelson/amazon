require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "Validations" do

    it "contains a title" do
      #GIVEN
      p = Product.new
      #WHEN
      validation_outcome = p.valid?
      #THEN
      expect(p.errors).to have_key(:title)
    end

    it "requires a price to be present" do
      #GIVEN
      p = Product.new
      #WHEN
      p.valid?
      #THEN
      expect(p.errors).to have_key(:price)
    end

    it "contains a unique title" do
      #GIVEN
      p1  = Product.create(title: "hey", description: "sup", price: 5, sale_price: 5)
      p   = Product.new(title: "hey")
      #WHEN
      p.valid?
      #THEN
      expect(p.errors).to have_key(:title)
    end

    it "requires sale_price to be present" do
      p = Product.new
      p.valid?
      expect(p.errors).to have_key(:sale_price)
    end

    it "requires a default sale_price that is the same as the price" do
      p = Product.new title: "hello", price: 5
      #p.valid?
      expect(p.sale_price).to eq(5)
    end

    it "requires sale price to be less than or equal to price" do
      #GIVEN
      p = Product.new title: "hello", price: 5, sale_price: 6
      #WHEN
      p.valid?
      #THEN
      expect(p.errors).to have_key(:sale_price)
    end

  end



end
