class TextToIngredientProcessor
  module UnitToken
    extend ActiveSupport::Concern

    private

    def process_unit_token(token)
      @unit << normalize_unit(token)
    end

    def unit_token?(token)
      return false if @previous_state != STATES[:amount] && @previous_state != STATES[:unit]

      supported_units.include?(token)
    end

    def normalize_unit(token)
      token = token.dup.split(' ').map do |t|
        t.singularize
      end.join(' ')

      if units.include?(token)
        token
      else
        unit_equivalences[token] || token
      end
    end

    def supported_units
      @supported_units ||= I18n.t('units').keys.map(&:to_s) + I18n.t('units').values.flatten.map(&:to_s)
    end

    def units
      @units ||= I18n.t('units').keys.map(&:to_s)
    end

    def unit_equivalences
      @unit_equivalences ||= begin
        h = {}
        I18n.t('units').invert.each do |keys,v|
          keys.each do |k|
            h[k.to_s] = v.to_s
          end
        end
        h
      end
    end
  end
end
