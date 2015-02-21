class Monument < ActiveRecord::Base
  belongs_to :collection

  validates :name, :description, presence: true, if: ->(m) {
    m.state == 'name_and_description' || m.state == 'confirmed'
  }

  scope :confirmed, -> { where(state: 'confirmed') }
end
