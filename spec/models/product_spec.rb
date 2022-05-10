require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    category = Category.new(name: "Ganja")
    it "is valid with valid attributes" do      
      product = Product.create(name: "bush", quantity: 2, price: 5, category: category  )
      expect(product).to be_valid
    end
    it "is not valid without a name" do
      product = Product.create(name: nil, quantity: 2, price: 5, category: category  )
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a quantity" do
      product = Product.create(name: "noquant", quantity: nil, price: 5, category: category  )
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a price" do
      category = Category.new(name: "Ganja")
      product = Product.create(name: "noprice", quantity: 2, price: "", category: category  )
      puts product.inspect
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a category" do
      product = Product.create(name: "nocate", quantity: 2, price: 5, category: nil  )
      expect(product.errors.full_messages).to_not be_empty
    end
  end
end 
