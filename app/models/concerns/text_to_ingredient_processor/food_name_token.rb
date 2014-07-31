class TextToIngredientProcessor
  module FoodNameToken
    extend ActiveSupport::Concern

    private

    def process_food_name_token(token)
      return if @current_state == STATES[:finish]

      if token == 'de' && @previous_state == STATES[:unit]
        return
      end

      if token == 'o' && @previous_state == STATES[:food_name]
        @current_state = STATES[:finish]
        return
      end

      @food_name << token
    end
  end
end
