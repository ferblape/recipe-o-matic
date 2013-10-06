class Recipe < ActiveRecord::Base
  include State

  validates :name, presence: true

  has_many :ingredients, -> { order("created_at ASC") }
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  scope :sorted_by_creation, -> { order("created_at DESC") }

  def self.build_from_url(url)
    fetcher = RecipeFetcher::Base.new(url)

    recipe = Recipe.new text: fetcher.text
    recipe.images = fetcher.images
    recipe.save!

    fetcher.ingredients.each do |str|
      Ingredient.build_from_raw(str, recipe)
    end

    recipe
  end
end
