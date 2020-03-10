require 'rest-client'
require 'json'

class App
	def initialize
		@url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
		@key = 'trnsl.1.1.20200309T234500Z.09dbaf2fcf6c9912.42736ca9bf3b48aa99f7f7f55b077645e4175bcd'
		puts 'Digite o texto que deseja traduzir'
		@text = gets
        puts 'Informe o idioma do texto '
        puts 'pt, en, fr, es, ru, etc'    
		@lang = gets.chomp
        puts 'Informe o idioma da tradução'
        puts 'pt, en, fr, es, ru, etc'        
		@lang += "-" + gets.chomp
		@response = get_response

		generate_file

	end

	def get_response
		response = RestClient.get(@url,
			params: {
				key: @key,
				text: @text,
				lang: @lang,
			}
		)
		return response
	end

	def get_translation
		JSON.parse(@response)
	end

    def generate_file
        date_name = Time.new.strftime('%d-%m-%y   %H:%M') + '.txt'
		file = File.open(date_name, 'w') do |f|
			f.puts get_translation
		end
	end
end

app = App.new