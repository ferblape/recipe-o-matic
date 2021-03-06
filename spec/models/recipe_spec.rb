require 'rails_helper'

describe Recipe do
  describe '#ingredientes_text=' do
    context 'when the recipe is new' do
      it 'should create an ingredient per line' do
        recipe = Recipe.new name: 'Pollo'
        recipe.ingredients_text = <<-INGREDIENTS
100 gr de jamón
sal
aceite
2 patatas
INGREDIENTS

        expect(recipe.ingredients.length).to eq(4)

        ingredient = recipe.ingredients.first
        expect(ingredient.text).to eq('100 gr de jamón')
        expect(ingredient.amount).to eq(100)
        expect(ingredient.unit).to eq('gr')
        expect(ingredient).to be_new_record
      end
    end

    context 'when the recipe is being updated' do
      it 'should create, update and remove ingredients' do
recipe = Recipe.new name: 'Pollo'
        recipe.ingredients_text = <<-INGREDIENTS
100 gr de jamón
sal
aceite
2 patatas
INGREDIENTS
        recipe.save!
        recipe.reload

        expect(recipe.ingredients.size).to eq(4)

        recipe.ingredients_text = <<-INGREDIENTS
200 gr de jamón
sal
3 patatas
1 pepino
1 chorizo
INGREDIENTS
        recipe.save!
        recipe.reload

        expect(recipe.ingredients.size).to eq(5)
        expect(recipe.ingredients.where(text: 'aceite')).to be_empty
      end
    end
  end
end
