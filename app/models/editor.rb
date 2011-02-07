# Redaktor do uwierzytelniania posiada email i hasło.
class Editor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one  :profile
  has_many :articles  

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  after_create :create_profile

  def create_profile
    Profile.create(:editor_id => self.id, :title => ' ')
  end
end
