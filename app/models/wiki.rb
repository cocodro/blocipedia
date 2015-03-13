class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :sections, dependent: :destroy

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def public?
    !private
  end
end
