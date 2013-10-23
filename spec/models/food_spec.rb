require 'spec_helper'

describe Food do
  describe '.merge' do
    it 'should update the ingredients to target the food kept' do
      r = Recipe.create name: 'Tortilla de patatas'
      f1 = Food.create! name: 'Patata'
      f2 = Food.create! name: 'Patata Grande'

      i1 = r.ingredients.create food_name: f1.name, amount: 2, unit: 'gr'
      i2 = r.ingredients.create food_name: f2.name, amount: 3, unit: 'gr'

      Food.merge f2, into: f1

      i2.reload
      i2.food.should == f1

      Food.where(id: f2.id).first.should be_nil
    end
  end
end
