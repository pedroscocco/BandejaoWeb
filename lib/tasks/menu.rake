namespace :menu do
	

  desc "TODO"
  task fetch: :environment do
  	require 'menugetter'
  	MenuGetter.update_menu


  end

end
