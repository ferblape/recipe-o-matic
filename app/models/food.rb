class Food < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients

  before_validation :sanitize_name

  validates :name, presence: true, uniqueness: true

  scope :popular, -> { select('distinct(foods.*), count(recipes.id) as count').
                         order('count DESC').
                         joins(:recipes, :ingredients).
                         group('foods.id, recipes.id').
                         limit(5) }

  def self.merge(food, options)
    destination = options.delete(:into)
    raise 'Missing destination food' if destination.nil?

    Ingredient.where(food_id: food.id).update_all(food_id: destination.id)

    food.destroy
  end

  private

  def sanitize_name
    self.name = self.name.downcase.strip
  end
end
