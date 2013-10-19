require 'textacular/searchable'

class Recipe < ActiveRecord::Base
  extend Searchable(:name, :text, :original_url)

  include State
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :original_url, uniqueness: true, allow_blank: true
  validates :slug, uniqueness: true, presence: true

  attr_accessor :ingredients_text

  has_many :ingredients
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true

  scope :sorted_by_creation, -> { order('created_at DESC') }

  before_validation :set_slug
  before_save :set_text_html

  def self.build_from_url(url)
    fetcher = RecipeFetcher::Base.new(url)

    recipe = Recipe.create! text: fetcher.text, name: fetcher.name,
                            remote_image_url: fetcher.image, original_url: fetcher.url

    fetcher.ingredients.each do |str|
      Ingredient.build_from_raw(str, recipe)
    end

    recipe
  end

  def ingredients_text=(value)
    value.each_line do |ingredient_text|
      Ingredient.build_from_raw(ingredient_text, self)
    end
  end

  def to_param
    slug
  end

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
