# Artykuł należy do jakieś kategorii.
# Zawarte są też tutaj parametry paginacji.
class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :editor
  cattr_reader :per_page
  @@per_page = 5
  validates_presence_of :title, :category
end
