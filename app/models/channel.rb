class Channel < ApplicationRecord
  has_many :messages, as: :messagable, dependent: :destroy
  belongs_to :user
  belongs_to :team
  validates_presence_of :slug, :team, :user
  validates :slug, format: { with: /\a[a-zA-Z0-9]+\Z/ }
  validates_uniqueness_of :slug, scope: :team_id
end
