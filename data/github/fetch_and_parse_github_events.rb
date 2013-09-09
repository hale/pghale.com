require 'octokit'
require 'json'

puts "please enter access token for Oktokit"
access_token = gets.chomp

client = Octokit::Client.new :access_token => access_token

puts "authorised as: " << client.user.name

events = []

PAGE_LIMIT = 10
PAGE_LIMIT.times do |n|
  events << client.user_events(client.user.login, :page => n)
end

events.flatten!

events_hash = {}
events.each do |event|
  timestamp = event.created_at.to_i
  events_hash[timestamp] = events_hash[timestamp] ? events_hash[timestamp] + 1 : 1
end


FILENAME = "data.json"
puts "overwrite data.json? Y/n"
return if (gets.chomp == "n")

File.open(FILENAME, "w") do |f|
  f.write(events_hash.to_json)
end

puts "Wrote #{events_hash.keys.size} records to #{FILENAME}"
