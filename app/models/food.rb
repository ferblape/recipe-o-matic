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

  private

  def sanitize_name
    self.name = self.name.downcase.strip
  end
end
