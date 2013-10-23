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

  describe '.find_or_initialize_by_name' do
    context 'when the food doesn´t exist' do
      it 'should return a new instance' do
        new_food = Food.find_or_initialize_by_name('wadus')
        new_food.should be_new_record
        new_food.name.should == 'wadus'
      end
    end

    context 'when the food exists' do
      before do
        @food = Food.create name: 'singular name', plural_name: 'plural name'
      end

      it 'should return the existing food searching by name' do
        Food.find_or_initialize_by_name('singular name').should == @food
      end

      it 'should return the existing food searching by plural name' do
        Food.find_or_initialize_by_name('plural name').should == @food
      end
    end
  end
end
