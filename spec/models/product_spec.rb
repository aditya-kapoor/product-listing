require 'rails_helper'

describe Product do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).only_integer }
  end
end