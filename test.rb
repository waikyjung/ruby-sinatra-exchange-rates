require "dotenv/load"
require "http"
require "json"


currency_list_http = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
raw_response = HTTP.get(currency_list_http)
raw_response_parsed = JSON.parse(raw_response).fetch("currencies")
@currency_list = raw_response_parsed.keys
pp @currency_list
#@currency_list = []
#raw_response_parsed.each { |currency| @currency_list.push(currency[0]) }
