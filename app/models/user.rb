class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  after_initialize :default_role

  def default_role
    self.role ||= 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end
end
