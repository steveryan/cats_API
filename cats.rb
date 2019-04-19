#Create an array of image links as strings for all cat pictures on /r/cats
#Create cats.hmtl that renders all pictures of the cats
require "json"
require "rest-client"
require "pry"

links = []

def make_html(links)
  html_links = links.map {|link| "<img src=\"" + link + "\" height=\"100\">" + "\n"}
  contents_of_file = '<!DOCTYPE html>' + "\n" + '<html>' + "\n" + '<head>' + "\n" + '<meta charset="UTF-8">' + "\n" + '<title>Here are some cat pictures</title>' + "\n" + '</head>' + "\n" + '<body>' + "\n" + "#{html_links.join}" + "\n" + '</body>' + "\n" + '</html>'
  #binding.pry
  File.write('Cats.html', contents_of_file)
end

request = RestClient.get "https://api.reddit.com/r/cats"
parsed_response = JSON.parse(request.body)
posts = parsed_response["data"]["children"]

posts.each do |json|
  if json["data"]["url"].include?(".jpg")
    links << json["data"]["url"]
  end
end

make_html(links)
