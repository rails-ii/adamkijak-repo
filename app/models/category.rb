class Category < ActiveRecord::Base
  has_many :articles, :dependent => :destroy
end
