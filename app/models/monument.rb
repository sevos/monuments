class Monument < ActiveRecord::Base
  belongs_to :collection
  has_many :photos

  validates :name, :description, presence: true, if: ->(m) {
    m.state == 'name_and_description' || m.state == 'confirmed'
  }

  scope :confirmed, -> { where(state: 'confirmed') }
  accepts_nested_attributes_for :photos, allow_destroy: true
end
