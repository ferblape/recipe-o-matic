class TextToIngredientProcessor
  # this method returns an array [amount, unit, food_name],
  # where:
  #   - amount is a float
  #   - unit is a string with the unit of measurement
  #   - food_name is the name of the food
  def self.process(str, food_klass)
    amount, amount_str = detect_amount(str)

    units_str = amount_str.present? ? str.gsub(amount_str, '') : str.dup
    unit, unit_str = detect_unit(units_str)

    food_str  = unit.present? ? units_str.gsub(unit_str, '') : units_str.dup
    food_name = detect_food_name(food_str)

    [amount, unit, food_name]
  end

  private

  def self.detect_amount(str)
    re = /\A(\d+[\.\/\-]?[\d+]?[\s*(\d+[\.\/\-]?[\d+]?)]*)\s+/
    if m = str.match(re)
      amount_str = m[0].strip
    else
      return nil
    end

    if amount_str =~ /\A\d+\/\d+\z/
      amount = case amount_str
        when '1/2' then 0.5
        when '1/4' then 0.25
        when '3/4' then 0.75
      end
    else
      amount = amount_str.to_f
    end

    return [amount, amount_str]
  end

  def self.detect_unit(str)
    supported_units.each do |unit|
      return [normalize_unit(unit), unit] if detected?(unit, str)
    end

    return [nil, nil]
  end

  def self.detect_food_name(str)
    str.strip
  end

  def self.detected?(unit, str)
    unit_words = unit.split(' ')
    if unit_words.size == 1
      supported_units.include?(unit)
    else
      # TODO
    end
  end

  def self.normalize_unit(unit)
    equivalences ||= {
      'g' => 'gr',
      'gramo' => 'gramo'
    }

    if equivalences.keys.include?(unit)
      return equivalences[unit]
    else
      return unit
    end
  end

  def self.supported_units
    @@supported_units ||= [
      'gr', 'g',
      'kg', 'mg',
      'ml', 'l',
      'puñado', 'trozo',
      'cucharada pequeña', 'cucharada grande',
      'taza', 'copa',
      'grano', 'hoja',
      'pastilla'
    ]
  end
end
