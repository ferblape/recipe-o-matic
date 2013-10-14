class IngredientPresenter
  def initialize(amount, unit, food_name)
    @amount = amount
    @unit = unit
    @food_name = food_name
  end

  def to_list_ingredient
    # If the amount in integer is different, keep the float
    amount = @amount.to_i != @amount ? @amount : @amount.to_i

    unit = @unit.blank? ? nil : format_unit(@unit, amount)

    [amount, unit, @food_name].compact.join(' ')
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
