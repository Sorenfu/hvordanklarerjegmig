require 'json'
require 'net/http'

PATH = '/Users/bob/hvordanklarerjegmig/financials/'
JSON_FILE = '/tmp/433410_urls.json'

file = File.read JSON_FILE
puts file
json = JSON.parse file
puts json

i = 0
json.each do |key, value|
  puts "Doing #{key}"
  puts "#{i} of #{json.size}"
  puts value
  if value
    uri = URI.parse(value)
    File.write(PATH + key + '.xml', Net::HTTP.get(uri))
  end
  i += 1
end