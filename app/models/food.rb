class Food < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients

  before_validation :sanitize_name

  validates :name, presence: true, uniqueness: true

  scope :listable, -> { where(skip_from_lists: false) }

  scope :popular, -> { listable.
                         select('distinct(foods.*), count(recipes.id) as count').
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

  def self.find_by_name(name)
    where("name = ? OR plural_name = ?", name, name).first
  end

  def self.find_or_initialize_by_name(name)
    Food.where("name = ? OR plural_name = ?", name, name).first ||
      Food.new(name: name, plural_name: name)
  end

  def plural_name
    read_attribute(:plural_name).blank? ? read_attribute(:name) : read_attribute(:plural_name)
  end

  private

  def sanitize_name
    self.name = self.name.downcase.strip
  end
end
