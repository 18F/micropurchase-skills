require 'bundler/setup'
require 'json'

require 'pry'
require 'rest-client'


url = 'https://micropurchase.18f.gov/api/v0/auctions.json'

response = RestClient.get(url, headers={})
parsed = JSON.parse(response.body)

auctions = parsed['auctions']

winning_bids = auctions.map do |auction|
  winning_bid = auction['winning_bid']
  auction_id = auction['id']
  skills = auction['skills']

  {
    'amount' => winning_bid['amount'],
    'bidder_id' => winning_bid['bidder_id'],
    'auction_url' => "https://micropurchase.18f.gov/auctions/#{auction_id}",
    'skills' => skills
  }
end

skills = auctions
           .map {|auction| auction['skills']}
           .flatten
           .uniq

skills_with_vendors = skills.map do |skill|
  auctions_for_skill = auctions
                        .select { |auction| auction['skills'].include?(skill) }

  bids = auctions_for_skill
           .map {|auction| auction['bids']}
           .flatten

  vendors = bids
              .map  {|bid| bid['bidder']}
              .uniq {|bidder| bidder['id']}

  vendors.each do |vendor|

    vendor['winning_bids'] = winning_bids
                              .select {|wb| wb['bidder_id'] == vendor['id']}
                              .select {|wb| wb['skills'].include?(skill)}
  end

  [skill, vendors]
end.to_h

STDOUT.puts JSON.pretty_generate(skills_with_vendors)
