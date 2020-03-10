require 'rest-client'
require 'json'

class Translate
	def initialize
		@url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
		@key = 'put your app key here'
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
	#method for get the response
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
	#method receive response and convert text
	def get_translation
		JSON.parse(@response)["text"]

	end
	#method use another method get_translation and use text response and langeuage for save in file
	def generate_file
		puts "Realizando Tradução... / Loading Translate"
		puts get_translation
		time = Time.new

        
		file = File.open(time.strftime("%m-%d-%Y.%H.%M.%S") + ".txt", 'w') do |fline|
			fline.puts @lang
			fline.puts ("#############################")
			fline.puts get_translation
			fline.puts ("#############################")

		end
	end
end

app = Translate.new