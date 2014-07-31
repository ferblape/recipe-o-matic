class TextToIngredientProcessor
  module AmountToken
    extend ActiveSupport::Concern

    private

    AMOUNTS_REGEXP = /\A(\d+[\.\/\-]?[\d+]?[\s*(\d+[\.\/\-]?[\d+]?)]*)/

    NATURAL_AMOUNTS = {
      'uno'    => 1.0,
      'un'     => 1.0,
      'dos'    => 2.0,
      'tres'   => 3.0,
      'cuatro' => 4.0
    }

    def amount_token?(token)
      (@previous_state == STATES[:root] || @previous_state == STATES[:amount]) &&
        (token =~ AMOUNTS_REGEXP || NATURAL_AMOUNTS.keys.include?(token))
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
  end
end
