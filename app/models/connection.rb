class Connection < ApplicationRecord
  belongs_to :user
  validates :remote_id, presence: true
  scope :active, -> { where(arhived: false) }

  def arhive
    self.arhived = true
    save
  end
end
