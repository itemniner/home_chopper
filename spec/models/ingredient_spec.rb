require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :challenge_ingredients }
    it { should have_many(:challenges).through(:challenge_ingredients) }
  end
end
