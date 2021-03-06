class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :collaborators
  has_many :users, through: :collaborators

  scope :visible_to, -> (user) { user ? all : where(private: false) }

  def public?
    !private
  end

  def user?
    self.user_id 
  end
end
