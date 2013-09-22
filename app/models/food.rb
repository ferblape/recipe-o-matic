class Food < ActiveRecord::Base
  before_validation :sanitize_name, :set_stemmed_name

  validates :name, presence: true
  validates :stemmed_name, presence: true

  private

  def sanitize_name
    self.name = self.name.downcase.strip
  end

  def set_stemmed_name
    self.stemmed_name = Lingua.stemmer(name, :language => 'es')
  end
end
