require 'nokogiri'
require 'json'

companies = JSON.parse(File.read('/users/bob/433410.json'))
xmls = Dir.glob('/Users/bob/hvordanklarerjegmig/financials/*.xml')
cvrs = xmls.map{|x| x.scan(/[0-9]+/).first}

companies.keep_if{|x| cvrs.include? x['_source']['Vrvirksomhed']['cvrNummer'].to_s}

Dir.glob('/Users/bob/hvordanklarerjegmig/financials/*.xml')[0..4].each do |file|
  doc = Nokogiri::XML File.open(file).read
  puts doc
end