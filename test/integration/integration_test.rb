require "test_helper"

# Test integracyjny symuluje zachowanie użytkownia, który wykonuje w kolejności następujące 
# kroki:
# 1. Zarejestrowanie się.
# 2. Utworzenie dwóch kategorii.
# 3. Utworzenie dwóch artykułów (po jednym dla każdej kategorii).
# 4. Wylogowanie się (sprawdzenie czy nie wyświetlają się linki przeznaczone dla redaktora).
# 5. Zalogowanie się.
# 6. Usunięcie artykułu.
# 6. Utworzenie 10 artykułów (testowanie paginacji).
#
# Po zakończonym teście wyświetlany jest w przeglądarce, efekt wizualny (html) efekt testów.
class IntegrationTest < ActionController::IntegrationTest

  setup do
  end

  test "use case scenario" do
    # wejdź na /
	visit '/'
	click_link 'Sign up'
	fill_in 'Email', :with => 'test@test.pl'
	fill_in 'Password', :with => 'test123'
	fill_in 'Password confirmation', :with => 'test123'
	click_button 'Sign up'
	page.has_content? 'You have signed up successfully.'
	click_link 'Manage categories'
	click_link 'New category'
	fill_in 'Name', :with => 'Category 1'
	click_button 'Create'
	page.has_content? 'Category was successfully created.'
	click_link 'Back'
	click_link 'New category'
	fill_in 'Name', :with => 'Category 2'
	click_button 'Create'
	page.has_content? 'Category was successfully created.'
	click_link 'Home'
	page.has_content? 'Category 1'
	click_link 'New article'
	fill_in 'Title', :with => 'Title 1'
	fill_in 'Content', :with => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit diam eget nisi cursus varius. Praesent condimentum facilisis tellus sed scelerisque. Curabitur lobortis scelerisque mollis. Ut tincidunt rutrum ullamcorper. Proin vel imperdiet eros. In cursus lobortis nisl consequat consequat. Morbi ultricies rutrum odio a porta. Etiam a ipsum urna. Praesent convallis, ligula vel rutrum pretium, massa felis dignissim nisi, et feugiat mauris felis sit amet orci. In viverra, orci sed fringilla aliquam, odio massa mattis purus, et dapibus metus urna et urna. Nunc interdum, diam ut adipiscing dapibus, neque purus pulvinar velit, nec vehicula est neque eu diam. Etiam vitae neque id felis pharetra cursus. Nulla metus lorem, dictum at consequat sit amet, porta a augue. Etiam eleifend imperdiet ligula id pretium. Suspendisse potenti. Nunc id vehicula est. Donec ullamcorper laoreet varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut est eros, sed pharetra dui. Etiam id enim nibh, nec placerat justo.'
	select 'Category 2', :from => 'Category'
	click_button 'Create'
	page.has_content? 'Article was successfully created'
	click_link 'Home'
	page.has_content? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit diam eget nisi cursus varius. Praesent condimentum facilisis tellus sed scelerisque. Curabitur lobortis scelerisque mollis. Ut tincidunt rutrum ullamcorper. Proin vel imperdiet eros. In cursus lobortis nisl consequat consequat. Morbi ultricies rutrum odio a porta. Etiam a ipsum urna. Praesent convallis, ligula vel rutrum pretium, massa felis dignissim nisi, et feugiat mauris felis sit amet orci. In viverra, orci sed fringilla...'

	click_link 'New article'
	fill_in 'Title', :with => 'Title 2'
	fill_in 'Content', :with => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas blandit diam eget nisi cursus varius. Praesent condimentum facilisis tellus sed scelerisque. Curabitur lobortis scelerisque mollis. Ut tincidunt rutrum ullamcorper. Proin vel imperdiet eros. In cursus lobortis nisl consequat consequat. Morbi ultricies rutrum odio a porta. Etiam a ipsum urna. Praesent convallis, ligula vel rutrum pretium, massa felis dignissim nisi, et feugiat mauris felis sit amet orci. In viverra, orci sed fringilla aliquam, odio massa mattis purus, et dapibus metus urna et urna. Nunc interdum, diam ut adipiscing dapibus, neque purus pulvinar velit, nec vehicula est neque eu diam. Etiam vitae neque id felis pharetra cursus. Nulla metus lorem, dictum at consequat sit amet, porta a augue. Etiam eleifend imperdiet ligula id pretium. Suspendisse potenti. Nunc id vehicula est. Donec ullamcorper laoreet varius. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut est eros, sed pharetra dui. Etiam id enim nibh, nec placerat justo.'
	select 'Category 1', :from => 'Category'
	click_button 'Create'
	page.has_content? 'Article was successfully created'
	click_link 'Sign out'
	page.has_no_content?('Sign up')
	page.has_no_content?('New article')
	page.has_no_content?('Manage categories')
	page.has_no_content?('Destroy')
	page.has_no_content?('Edit')
    click_link 'Sign in'
	fill_in 'Email', :with => 'test@test.pl'	
	fill_in 'Password', :with => 'test123'
	click_button 'Sign in'
	page.has_content? 'You have signed in successfully.'
	click_link 'Destroy'
	page.has_no_content?('Title 2')
	1.upto(10) { |i|
		click_link 'New article'
		fill_in 'Title', :with => "Title #{i}"
		fill_in 'Content', :with => "Content of article #{i} " * 20
		select "Category #{i%1+1}", :from => 'Category'
		click_button 'Create'
		page.has_content? 'Article was successfully created'
		click_link 'Back'
	}
	click_link 'Sign out'
	page.has_no_content?('Title 4')
	click_link '2'
	page.has_content?('Title 4')
	save_and_open_page
  end
 
end
