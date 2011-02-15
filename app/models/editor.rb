# Redaktor do uwierzytelniania posiada email i hasło.
class Editor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_one  :profile
  has_many :articles  

  # Setup accessible (or protected) attributes for your model
  attr_accessor :invite_code
  attr_accessible :email, :password, :password_confirmation, :invite_code
  after_create :create_profile

  validates_each :invite_code, :on => :create do |record, attr, value|
    record.errors.add attr, ": Please enter correct invite code" unless value && value == "12345" 
  end


  def create_profile
    Profile.create(:editor_id => self.id, :title => ' ')
  end
end
