require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @list = @parsed_data["currencies"]

  @currencies = @list.keys

  erb(:home)
end

get("/:first") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @list = @parsed_data["currencies"]

  @currencies = @list.keys

  @money = params["first"]

  erb(:first)
end

get("/:first/:second") do
  api_url = "https://api.exchangerate.host/convert?from=#{params["first"]}&to=#{params["second"]}&amount=1&access_key=#{ENV.fetch("EXCHANGE_RATE_KEY")}"

  @raw_response = HTTP.get(api_url)

  @raw_string = @raw_response.to_s

  @parsed_data = JSON.parse(@raw_string)

  @result = @parsed_data["result"]
  erb(:second)
end
