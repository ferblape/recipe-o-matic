class Recipe < ActiveRecord::Base
  include State
  mount_uploader :image, ImageUploader

  validates :name, presence: true

  has_many :ingredients, -> { order("created_at ASC") }
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  scope :sorted_by_creation, -> { order("created_at DESC") }

  def self.build_from_url(url)
    fetcher = RecipeFetcher::Base.new(url)

    recipe = Recipe.create! text: fetcher.text, name: fetcher.name,
                            remote_image_url: fetcher.image, original_url: fetcher.url

    fetcher.ingredients.each do |str|
      Ingredient.build_from_raw(str, recipe)
    end

    recipe
  end
end
