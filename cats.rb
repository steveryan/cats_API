#Create an array of image links as strings for all cat pictures on /r/cats
#Create cats.hmtl that renders all pictures of the cats
require "json"
require "rest-client"
require "pry"

links = []

request = RestClient.get "https://api.reddit.com/r/cats"
parsed_response = JSON.parse(request.body)
posts = parsed_response["data"]["children"]

posts.each do |json|
  links << json["data"]["url"]
end

puts links
