class Monument < ActiveRecord::Base
  belongs_to :collection
  has_many :photos

  STATES = %w(name_and_description photos confirmed)
  def self.in_state(state)
    ->(monument) do
      STATES.slice_before { |s| s == state }.to_a.
        last.include?(monument.state)
    end
  end

  validates :name, :description, presence: true,
            if: in_state('name_and_description')
  validate :at_least_one_photo, if: in_state('photos')


  scope :confirmed, -> { where(state: 'confirmed') }
  accepts_nested_attributes_for :photos, allow_destroy: true

  private

  def at_least_one_photo
    unless photos.any?
      errors.add(:photos, "At least one photo required")
    end
  end
end
