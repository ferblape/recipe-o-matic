class Food < ActiveRecord::Base
  before_validation :sanitize_name

  validates :name, presence: true, uniqueness: true

  private

  def sanitize_name
    self.name = self.name.downcase.strip
  end
end
