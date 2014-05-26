require 'rubygems'
require 'nokogiri'
require 'open-uri'

class MenuGetter

	def self.update_menu
		menu = getMenu(nil)
		insertIntoDatabase(menu, "Central")

		menu = getMenu("quimica")
		insertIntoDatabase(menu, "Quimica")
	end

	def self.insertIntoDatabase(menuHash, restaurant)
		dish_types = ['Arroz/Feijão', 'Principal', 'Acompanhamento', 'Salada', 'Opcional', 'Sobremesa', 'Calorias']

		date = menuHash[:date]
		menu = Menu.create(restaurant:restaurant, date:date)
		strings = menuHash[:days]
		strings.each_with_index do |substrings, index|
			day = menu.days.create(name:substrings[0], datetime:date+(60*60*12*index))
			substrings.delete_at(0)
			if substrings.count > 7
				dish_types.insert(3, 'Salada')
			end
			substrings.each_with_index do |dish, index|
				day.dishes.create(name:dish, dish_type:dish_types[index])
			end
		end

	end

	def self.getMenu(restaurante)
		url = "http://www.usp.br/coseas/cardapio#{restaurante}.html"
		doc = Nokogiri::HTML(open(url))

		menu = Hash.new

		doc.xpath("//pre").each do |pre|
			/(\d\d)\/(\d{2})\/(\d{2,4})/.match(pre.text) do |match|
				year = match[3]
				year = "20" + year if year.length < 4

				date = Time.new(year, match[2], match[1])

				wdays = ((date.wday + 6) % 7)

				date = date - (60*60*24*wdays)

				menu[:date] = date
			end
			break if menu[:date]
		end

		strings = Array.new

		doc.xpath("//td").each do |e|
			substrings = Array.new
			parse_html(e, substrings)
			if restaurante == 'quimica'
				substrings.delete_at(-2)
			else
				substrings.each {|str| str.gsub!('/refresco', '')}
			end	
			strings << substrings
		end

		days = ["SEGUNDA", "TER", "QUARTA", "QUINTA", "SEXTA", "BADO", "DOMINGO"]

		strings.select! do |subs|
			days.any? {|day| subs[0].include? day}
		end

		menu[:days] = strings

	  return menu
	end

	def self.parse_html(elem, sub)
		elem.children.each do |e| 
			if e.name == 'pre'
				parse_pre(e, sub)
			elsif e.name == 'p' || e.name == 'font' || e.name == 'span'
				parse_notpre(e, sub)
			else
				parse_html(e, sub)
			end
		end
	end

	def self.parse_pre(elem, sub)
		elem.children.each do |elem|
			if elem.name == 'p'|| elem.name == 'span'
				parse_notpre(elem, sub)
				elem.content = ''
			end
		end
		elem.css('br').each{ |br| br.replace "\n" }
		text = elem.text
		text.split("\n").each do |e|
			clean(e)
			if e != nil && e != ""
				sub << e
			end
		end
	end

	def self.parse_notpre(elem, sub)
		elem.css('br').each{ |br| br.replace ";" }
		text = elem.text
		text.gsub!(/\n/, "")
		text.split(";").each do |e|
			clean(e)
			if e != nil && e != ""
				sub << e
			end
		end
	end

	def self.clean(string)
		string.gsub!(/[^\w\s\-\/]/, '')
		string.squeeze!(" ")
		string.strip!
	end
end


