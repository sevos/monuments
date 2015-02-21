class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :monuments, dependent: :destroy
  validates :title, :user, presence: true

  def confirmed_monuments
    monuments.confirmed
  end
end
