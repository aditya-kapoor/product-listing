class Product < ActiveRecord::Base
  # Validations
  validates :name, :description, :price, presence: :true
  validates :price, numericality: { only_integer: true }, allow_blank: true
end
