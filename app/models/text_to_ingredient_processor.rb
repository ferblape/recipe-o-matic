class TextToIngredientProcessor
  attr_reader :amount, :unit, :food_name

  def initialize(str)
    @str = str

    @amount = nil
    @unit = nil
    @food_name = nil

    @current_state = STATES[:root]
  end

  # this method returns an array [amount, unit, food_name],
  # where:
  #   - amount is a float
  #   - unit is a string with the unit of measurement
  #   - food_name is the name of the food
  def process!
    tokens = tokenize(@str)

    while tokens.any?
      token = tokens.shift
      process_token(token)
    end

    @unit = @unit.join(' ') if @unit && @unit.any?
    @food_name = @food_name.join(' ') if @food_name && @food_name.any?
  end

  private

  STATES = {
    root: 0,
    amount: 1,
    unit: 2,
    food_name: 3,
    finish: 4
  }

  AMOUNTS_REGEXP = /\A(\d+[\.\/\-]?[\d+]?[\s*(\d+[\.\/\-]?[\d+]?)]*)/
  NATURAL_AMOUNTS = {
    'uno'    => 1.0,
    'un'     => 1.0,
    'dos'    => 2.0,
    'tres'   => 3.0,
    'cuatro' => 4.0
  }

  SUPPORTED_UNITS = [
    'gr', 'g',
    'kg', 'mg',
    'ml', 'l',
    'puñado', 'trozo',
    'cucharada',
    'cucharada pequeña',
    'pequeña',
    'grande',
    'taza', 'copa',
    'grano', 'hoja',
    'pastilla'
  ]

  def tokenize(str)
    # remove text inside parenthesis
    str = str.gsub(/(\([^\)]+\))/,'')

    tokens = []
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

    tokens
  end

  def process_token(token)
    @previous_state = @current_state

    kind_of_token = detect_kind_of_token(token)

    if kind_of_token == :amount
      @current_state = STATES[:amount]
      process_amount_token(token)
    elsif kind_of_token == :unit
      @current_state = STATES[:unit]
      process_unit_token(token)
    elsif kind_of_token == :food_name
      @current_state = STATES[:food_name] if @previous_state != STATES[:finish]
      process_food_name_token(token)
    end
  end

  def detect_kind_of_token(token)
    return :food_name if @current_state == STATES[:food_name] ||
                          @current_state == STATES[:finish]

    if detect_amount(token)
      :amount
    elsif detect_unit(token)
      :unit
    else
      :food_name
    end
  end

  def process_amount_token(token)
    # Detect fractions
    if token =~ /\A\d+\/\d+\z/
      amount = case token
        when '1/2' then 0.5
        when '1/3' then 0.3
        when '2/3' then 0.6
        when '1/4' then 0.25
        when '3/4' then 0.75
      end
    elsif NATURAL_AMOUNTS.keys.include?(token)
      amount = NATURAL_AMOUNTS[token]
    else
      amount = token.to_f
    end

    if @amount.nil?
      @amount = amount
    else
      @amount += amount
    end
  end

  def process_unit_token(token)
    @unit ||= []
    @unit << normalize_unit(token)
  end

  def process_food_name_token(token)
    return if @current_state == STATES[:finish]

    @food_name ||= []
    if token == 'de' && @previous_state == STATES[:unit]
      return
    end

    if token == 'o' && @previous_state == STATES[:food_name]
      @current_state = STATES[:finish]
      return
    end

    @food_name << token
  end

  def detect_amount(token)
    (@previous_state == STATES[:root] || @previous_state == STATES[:amount]) &&
       (token =~ AMOUNTS_REGEXP || NATURAL_AMOUNTS.keys.include?(token))
  end

  def detect_unit(token)
    return false if @previous_state != STATES[:amount] &&
                    @previous_state != STATES[:unit]

    SUPPORTED_UNITS.each do |unit|
      return true if detected?(unit, token)
    end

    return false
  end

  def detected?(unit, token)
    SUPPORTED_UNITS.include?(normalize_unit(token))
  end

  def normalize_unit(token)
    equivalences = {
      'g' => 'gr',
      'gramo' => 'gr',
      'kilo' => 'kg',
      'kilogramo' => 'kg',
      'cucharadita' => 'cucharada pequeña'
    }

    token = token.dup.split(' ').map do |t|
      t.singularize
    end.join(' ')

    if equivalences.keys.include?(token)
      return equivalences[token]
    elsif token =~ /\.\z/
      return token.gsub('.', '')
    else
      return token
    end
  end
end
