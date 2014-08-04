class TextToIngredientProcessor
  module UnitToken
    extend ActiveSupport::Concern

    private

    def process_unit_token(token)
      @unit << normalize_unit(token)
    end

    def unit_token?(token)
      # use a @previous token?
      return false if @previous_state != STATES[:amount]# && @previous_state != STATES[:unit]

      supported_units.include?(token)
    end

    def normalize_unit(token)
      # Singularize all the token words
      token = token.split(' ').map do |t|
        t.singularize
      end.join(' ')

      unit_equivalences[token] || token
    end

    def supported_units
      @supported_units ||= I18n.t('units').flatten.flatten.map(&:to_s)
    end

    def unit_equivalences
      @unit_equivalences ||= begin
        {}.tap do |h|
          I18n.t('units').invert.each do |keys,v|
            keys.each do |k|
              h[k.to_s] = v.to_s
            end
          end
        end
      end
    end
  end
end
