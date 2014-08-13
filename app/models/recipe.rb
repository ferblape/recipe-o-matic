require 'textacular/searchable'

class Recipe < ActiveRecord::Base
  extend Searchable(:name, :text, :original_url)

  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :original_url, uniqueness: true, allow_blank: true
  validates :slug, uniqueness: true

  attr_accessor :ingredients_text

  has_many :ingredients
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  scope :sorted_by_creation, -> { order('created_at DESC') }

  before_validation :set_slug
  before_save :set_text_html

  def self.build_from_url(url)
    fetcher = RecipeFetcher::Base.new(url)

    recipe = Recipe.create! text: fetcher.text, name: fetcher.name,
                            remote_image_url: fetcher.image, original_url: fetcher.url,
                            ingredients_text: fetcher.ingredients
    recipe
  end

  def ingredients_text=(ingredients)
    ingredients = ingredients.split("\n") if ingredients.is_a?(String)
    self.ingredients.clear if self.ingredients.any?

    self.ingredients = ingredients.map do |ingredient_line|
      Ingredient.build_from_raw(ingredient_line)
    end
  end

  def ingredients_text
    ingredients.map(&:text).join("\n")
  end

  def to_param
    slug
  end

  def as_json(options = nil)
    {label: self.name, value: self.id}
  end

  #### Metadata

  TIME_VALUES   = ['lunch', 'dinner', 'any']
  SEASON_VALUES = ['spring', 'summer', 'autumn', 'winter', 'any']

  hstore_accessor :metadata,
    time: :string,
    season: :string,
    vegetarian: :boolean

  validates :time, inclusion: { in: TIME_VALUES }, allow_nil: true
  validates :season, inclusion: { in: SEASON_VALUES }, allow_nil: true

  private

  def set_text_html
    if self.text.present?
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, underline: true)
      self.text_html = markdown.render(self.text)
    end
  end

  def set_slug
    if name.present?
      self.slug = self.name.parameterize
    end
  end
end
