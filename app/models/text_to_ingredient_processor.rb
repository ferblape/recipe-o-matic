class TextToIngredientProcessor
  include UnitToken
  include AmountToken
  include FoodNameToken

  def initialize(raw_string, ingredient)
    @ingredient = ingredient

    @text = raw_string.gsub(/\A([^0-9a-zA-Z]+)/, '').downcase
    @amount = nil
    @unit = []
    @food_name = []

    @current_state = STATES[:root]
  end

  def process
    tokens = tokenize(@text)

    while tokens.any?
      process_token(tokens.shift)
    end

    @ingredient.text = @text
    @ingredient.unit = @unit.any? ? @unit.join(' ') : nil
    @ingredient.amount = @amount
    @ingredient.food_name = @food_name.join(' ')
    @ingredient
  end

  private

  STATES = {
    root: 0,
    amount: 1,
    unit: 2,
    food_name: 3,
    finish: 4
  }

  def tokenize(str)
    # remove text inside parenthesis
    str = str.gsub(/(\([^\)]+\))/,'')

    [].tap do |tokens|
      str.split(' ').each do |token|
        token = token.downcase.strip

        if token =~ AMOUNTS_REGEXP
          if $1.length != token.length
            tokens << $1
            tokens << token.gsub($1, '').strip
            next
          end
        end

        tokens << token
      end
    end
  end

  def process_token(token)
    @previous_state = @current_state

    case detect_kind_of_token(token)
      when :amount
        @current_state = STATES[:amount]
        process_amount_token(token)
      when :unit
        @current_state = STATES[:unit]
        process_unit_token(token)
      when :food_name
        @current_state = STATES[:food_name] if @previous_state != STATES[:finish]
        process_food_name_token(token)
    end
  end

  def detect_kind_of_token(token)
    return :amount     if amount_token?(token)
    return :unit       if unit_token?(token)
    return :food_name
  end
end
