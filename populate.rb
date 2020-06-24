require 'net/http'
require 'net/https' # for ruby 1.8.7
require 'json'

module Populate
  def self.banks
    http = Net::HTTP.new('raw.githubusercontent.com', 443); http.use_ssl = true
    JSON.parse http.get('/devisaah/populate_bancos/master/banks.json').body
  end


  def self.create
    banks.each do |bank|
      Bank.create(
        description: bank['Name'], 
        code: bank['Code']
      ) 
      puts "Adding bank #{bank['Name']}"
    end
  end
end

Populate.create
