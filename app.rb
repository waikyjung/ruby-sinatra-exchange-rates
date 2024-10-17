require "sinatra"
require "sinatra/reloader"
require "dotenv/load"
require "http"
require "json"

get("/") do
  currency_list_http = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(currency_list_http)
  raw_response_parsed = JSON.parse(raw_response).fetch("currencies")
  @currency_list = raw_response_parsed.keys
  erb(:currency_pairs)
end

get("/:currency_from") do
  @currency_from = params.fetch("currency_from")

  currency_list_http = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(currency_list_http)
  raw_response_parsed = JSON.parse(raw_response).fetch("currencies")
  @currency_list = raw_response_parsed.keys
  erb(:convert)
end

get("/:currency_from/:currency_to") do
  @currency_from = params.fetch("currency_from")
  @currency_to = params.fetch("currency_to")

  currency_convert_http = "https://api.exchangerate.host/convert?from=#{@currency_from}&to=#{@currency_to}&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"
  raw_response = HTTP.get(currency_convert_http)
  @converted = JSON.parse(raw_response).fetch("result").to_f
  erb(:result)
end
