# Kategoria zawiera wiele artykułów.
# Jeśli zostanie usunięta, to artykłu należące do tej katogorii również przestaną istnieć.
class Category < ActiveRecord::Base
  has_many :articles, :dependent => :destroy
end
