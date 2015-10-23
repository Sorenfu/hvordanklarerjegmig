require 'nokogiri'

companies =

Dir.glob('/Users/bob/hvordanklarerjegmig/financials/*.xml')[0..4].each do |file|
  doc = Nokogiri::XML File.open(file).read
  puts doc
end