require 'faker'
puts 'Setting up example database'
editor = Editor.create(:email => "adam@kijak.pl", :password => "123456", 
 			  :password_confirmation => "123456", :invite_code => "12345")
puts 'New editor created: ' << editor.email
2.upto(10) do |i|
  editor = Editor.create(:email => Faker::Internet.email, :password => "123456", 
 			  :password_confirmation => "123456", :invite_code => "12345")
  puts 'New editor created: ' << editor.email
end
1.upto(10) do |i|
  category = Category.create(:name => Faker::Lorem.words(rand(1)+1).join(" ").capitalize, 
  			 :editor_id => i)
  print 'New category created: ' << category.name
  print ' with articles: '
  1.upto(rand(10)) do |j|
    article = Article.create(:title => Faker::Lorem.words(rand(2)+1).join(" ").capitalize, 
    			:content => "<p>"+(1..5).inject(""){|res,p| res + Faker::Lorem.paragraph(20) + 
				"<br>"} +"</p>",
				:category_id => i, :editor_id => i)
	print "#{j} "
  end
  puts
end
