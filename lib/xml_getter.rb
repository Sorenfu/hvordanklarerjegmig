require 'elasticsearch'
require 'json'

DOMAIN = 'http://distribution.virk.dk/'
INDEX = 'offentliggoerelser'

def parse(cvr)
  puts body_query(cvr)
  data = client.search index: INDEX,
                       body: body_query(cvr),
                       size: 1
  data['hits']['hits']
end

def client
  Elasticsearch::Client.new(
      url: "http://distribution.virk.dk:80"
  )
end

#Vrvirksomhed.hovedbranche.branchekode:433410

def body_query(cvr)
  {
      query: {
          bool: {
              must: [
                  {
                      match: {
                          cvrNummer: cvr
                      },
                  }
              ]
          }
      },
      sort: {offentliggoerelsesTidspunkt: {order: :desc}}
  }
end


cvrs = [26722535]
codes = [433410] #433410
current_code = nil
jsons = []
big_result = {}

codes.each do |code|
  file = File.read "/tmp/#{code}.json"
  jsons = JSON.parse file
  current_code = code
end

jsons.each_with_index do |json, i|
  puts "#{i} of #{jsons.size}"
  cvr = json['_source']['Vrvirksomhed']['cvrNummer']
  puts "Doing #{cvr}"
  result = parse(cvr)
  unless result.empty?
    url = result.first['_source']['dokumenter'].map { |x| x['dokumentUrl'] if x['dokumentMimeType'] == 'application/xml' }.compact.first
    big_result[cvr] = url
  end
  puts big_result
  File.open("/tmp/#{current_code}_urls.json", 'wb') do |file|
    file.write big_result.to_json
  end
end

