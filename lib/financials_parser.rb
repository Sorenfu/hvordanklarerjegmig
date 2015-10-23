require 'nokogiri'
require 'json'

path = '/Users/bob/hvordanklarerjegmig/resources/companies_with_financials.json'
companies = JSON.parse(File.read path)

#ProfitLoss
#EmployeeBenefitsExpense


Dir.glob('/Users/bob/hvordanklarerjegmig/financials/*.xml')[0..4].each do |file|
  doc = Nokogiri::XML File.open(file).read
  puts doc
end