module State
  extend ActiveSupport::Concern

  STATES = {
    pending: 0,
    published: 1
  }

  included do
    scope :pending,   -> { where(state: STATES[:pending]) }
    scope :published, -> { where(state: STATES[:published]) }
  end

end
