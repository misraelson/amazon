require 'rails_helper'

RSpec.describe Review, type: :model do
  def review_attributes
    FactoryGirl.attributes_for(:review)
  end
    describe "validations" do
      it "requires a start count" do
        r = Review.new review_attributes.merge(stars: nil)
        expect(r).to be_invalid
      end
      it "contains a number between 1 and 5" do
        r = Review.new review_attributes.merge(stars: 6)
        expect(r).to be_invalid
      end
    end

end
