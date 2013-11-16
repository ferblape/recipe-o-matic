class IngredientPresenter
  def initialize(list_of_ingredient)
    @list_of_ingredient = list_of_ingredient
  end

  def to_list_ingredient
    list = []
    @list_of_ingredient.in_groups_of(3) do |item|
      amount    = item.first
      unit      = item.second
      food      = Food.find_by_name(item.third)

      # If the amount in integer is different, keep the float
      amount = amount.to_i != amount ? amount : amount.to_i
      amount = "" if amount == 0

      unit = unit.blank? ? "" : format_unit(unit, amount)

      list << [amount, unit, (amount == 1 ? food.name : food.plural_name)].compact.join(' ')
    end

    list
  end

  private

  def format_unit(unit, amount)
    unit = UNIT_VIEW_NAME[unit] || unit
    unit + ' ' + I18n.t('lists.ingredient_presenter.of')
  end

  UNIT_VIEW_NAME = {
    'gr' => 'gr.',
    'g' => 'gr.',
    'kg' => 'kg.',
    'mg' => 'mg.',
    'ml' => 'ml.',
    'l' => 'l.'
  }
end
