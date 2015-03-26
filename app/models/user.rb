class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis
  has_many :collaborators
  has_many :collaborations, through: :collaborators, source: :wiki


  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end
end
